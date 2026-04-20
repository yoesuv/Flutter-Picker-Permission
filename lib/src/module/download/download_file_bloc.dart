import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_picker/src/core/data/constants.dart';
import 'package:flutter_picker/src/module/download/download_file_event.dart';
import 'package:flutter_picker/src/module/download/download_file_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const downloadPort = "downloader_send_port";

@pragma('vm:entry-point')
class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  final ReceivePort _port = ReceivePort();

  DownloadFileBloc() : super(const DownloadFileState()) {
    on<DownloadFileInitEvent>(_init);
    on<DownloadFileStartAndroidEvent>(_onStartDownloadAndroid);
    on<DownloadFileStartIOSEvent>(_onStartDownloadIos);
    on<DownloadFileUpdateEvent>(_onUpdateDownload);
  }

  void _init(
    DownloadFileInitEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    if (Platform.isAndroid) {
      IsolateNameServer.registerPortWithName(_port.sendPort, downloadPort);
      _port.listen((dynamic data) {
        try {
          final status = data[1] as int;
          final progress = data[2] as int;
          add(
            DownloadFileUpdateEvent(
              downloadTaskStatus: DownloadTaskStatus.values.elementAt(status),
              progress: progress,
            ),
          );
        } catch (e) {
          debugPrint("DownloadFileBloc # ERROR $e");
        }
      });
      FlutterDownloader.registerCallback(downloadCallback);
    }
  }

  void _onStartDownloadAndroid(
    DownloadFileStartAndroidEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final config = _androidDownloadConfig(androidInfo.version.sdkInt);
    await _checkAndroid(
      permission: config.permission,
      saveInPublicStorage: config.saveInPublicStorage,
      emit: emit,
    );
  }

  ({Permission permission, bool saveInPublicStorage}) _androidDownloadConfig(
    int sdkInt,
  ) {
    if (sdkInt >= 30) {
      return (permission: Permission.notification, saveInPublicStorage: true);
    } else {
      return (permission: Permission.storage, saveInPublicStorage: false);
    }
  }

  void _onStartDownloadIos(
    DownloadFileStartIOSEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    final documents = await getApplicationDocumentsDirectory();
    final pathAndName =
        "${documents.path}${Platform.pathSeparator}document_downloaded_with_dio.pdf";
    debugPrint("DownloadFileBloc # ios path $pathAndName");
    Dio().download(
      linkDownloadFile,
      pathAndName,
      onReceiveProgress: (count, total) {
        debugPrint("DownloadFileBloc # count $count/total $total");
        if (count == total) {
          debugPrint("DownloadFileBloc # DOWNLOAD FINISH");
        }
      },
    );
  }

  void _onUpdateDownload(
    DownloadFileUpdateEvent event,
    Emitter<DownloadFileState> emit,
  ) {
    debugPrint(
      "DownloadFileBloc # ${event.downloadTaskStatus}/${event.progress}",
    );
    emit(
      state.copyWith(
        progress: event.progress,
        downloadTaskStatus: event.downloadTaskStatus,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final send = IsolateNameServer.lookupPortByName(downloadPort);
    send?.send([id, status, progress]);
  }

  Future<void> _checkAndroid({
    required Permission permission,
    required bool saveInPublicStorage,
    required Emitter<DownloadFileState> emit,
  }) async {
    final result = await permission.request();
    if (result == PermissionStatus.granted) {
      final directory = saveInPublicStorage
          ? Directory("/storage/emulated/0/Download")
          : await getExternalStorageDirectory();
      final path = directory?.path ?? "";
      await _downloadFile(path: path, saveInPublicStorage: saveInPublicStorage);
    } else {
      emit(state.copyWith(permissionStatus: null));
      emit(state.copyWith(permissionStatus: result));
    }
  }

  Future<void> _downloadFile({
    required String path,
    required bool saveInPublicStorage,
  }) async {
    await FlutterDownloader.enqueue(
      url: linkDownloadFile,
      savedDir: path,
      fileName: 'Sample Document pdf.pdf',
      saveInPublicStorage: saveInPublicStorage,
    );
  }
}

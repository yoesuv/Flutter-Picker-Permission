import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_picker/src/core/data/constants.dart';
import 'package:flutter_picker/src/module/download/download_file_event.dart';
import 'package:flutter_picker/src/module/download/download_file_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const downloadPort = "downloader_send_port";

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  final ReceivePort _port = ReceivePort();

  DownloadFileBloc() : super(const DownloadFileState()) {
    on<DownloadFileInitEvent>(_init);
    on<DownloadFileStartAndroidEvent>(_onStartDownloadAndroid);
    on<DownloadFileStartIOSEvent>(_onStartDownloadIos);
  }

  void _init(
    DownloadFileInitEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    IsolateNameServer.registerPortWithName(_port.sendPort, downloadPort);
    _port.listen((dynamic data) {
      try {
        //final id = data[0] as String;
        final status = data[1] as int;
        final progress = data[2] as int;
        debugPrint("DownloadFileBloc # status $status");
        debugPrint("DownloadFileBloc # progress $progress");
      } catch (e) {
        debugPrint("DownloadFileBloc # ERROR $e");
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _onStartDownloadAndroid(
    DownloadFileStartAndroidEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;
    if (sdkInt >= 33) {
      await _checkAndroid(permission: Permission.notification);
    } else {
      await _checkAndroid(permission: Permission.storage);
    }
  }

  void _onStartDownloadIos(
    DownloadFileStartIOSEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    final documents = await getApplicationDocumentsDirectory();
    final path = documents.path;
    await _downloadFile(path: path);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final send = IsolateNameServer.lookupPortByName(downloadPort);
    send?.send([id, status, progress]);
  }

  Future<void> _checkAndroid({
    required Permission permission,
  }) async {
    Directory? directory = Directory("/storage/emulated/0/Download");
    final result = await permission.request();
    if (result == PermissionStatus.granted) {
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
      final path = directory?.path ?? "";
      await _downloadFile(path: path);
    }
  }

  Future<void> _downloadFile({required String path}) async {
    await FlutterDownloader.enqueue(
      url: linkDownloadFile,
      savedDir: path,
      saveInPublicStorage: true,
    );
  }
}

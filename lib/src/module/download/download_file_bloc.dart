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

const downloadPort = "downloader_send_port";

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {

  final ReceivePort _port = ReceivePort();

  DownloadFileBloc() : super(DownloadFileState()) {
    on<DownloadFileInitEvent>(_init);
    on<DownloadFileStartAndroidEvent>(_onStartDownloadAndroid);
    on<DownloadFileStartIOSEvent>(_onStartDownloadIos);
  }

  void _init(
    DownloadFileInitEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    await FlutterDownloader.initialize(ignoreSsl: true, debug: true);
    IsolateNameServer.registerPortWithName(_port.sendPort, downloadPort);
    _port.listen((dynamic data) {
      try {
        final id = data[0] as String;
        final status = data[1] as int;
        final progress = data[2] as int;
        debugPrint("DownloadFileBloc # id $id/status $status/progress $progress");
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
    } else {}
  }

  void _onStartDownloadIos(
    DownloadFileStartIOSEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    final documents = await getApplicationDocumentsDirectory();
    final path = documents.path;
    await FlutterDownloader.enqueue(url: linkDownloadFile, savedDir: path);
  }

  static void downloadCallback(String id, int status, int progress) {
    final send = IsolateNameServer.lookupPortByName(downloadPort);
    send?.send([id, status, progress]);
  }

}

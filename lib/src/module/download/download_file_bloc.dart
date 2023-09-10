import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_picker/src/core/data/constants.dart';
import 'package:flutter_picker/src/module/download/download_file_event.dart';
import 'package:flutter_picker/src/module/download/download_file_state.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  DownloadFileBloc() : super(DownloadFileState()) {
    on<DownloadFileStartAndroidEvent>(_onStartDownloadAndroid);
    on<DownloadFileStartIOSEvent>(_onStartDownloadIos);
  }

  void _onStartDownloadAndroid(
      DownloadFileStartAndroidEvent event,
    Emitter<DownloadFileState> emit,
  ) async {
    debugPrint("DownloadFileBloc # start download android");
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;
    if (sdkInt >= 33) {

    } else {

    }
  }

  void _onStartDownloadIos(
      DownloadFileStartIOSEvent event,
      Emitter<DownloadFileState> emit,
      ) async {
    final documents = await getApplicationDocumentsDirectory();
    final path = documents.path;
    await FlutterDownloader.enqueue(url: linkDownloadFile, savedDir: path);
  }

}

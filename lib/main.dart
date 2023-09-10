import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_picker/src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FlutterDownloader.registerCallback(downloadCallback);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
void downloadCallback(
  String id,
  int status,
  int progress,
) {
  debugPrint(
    'Callback on background isolate: '
    'task ($id) is in status ($status) and process ($progress)',
  );
  IsolateNameServer.lookupPortByName('downloader_send_port')
      ?.send([id, status, progress]);
}

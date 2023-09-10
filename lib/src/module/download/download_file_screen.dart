import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/download/download_file_bloc.dart';
import 'package:flutter_picker/src/module/download/download_file_event.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class DownloadFileScreen extends StatefulWidget {
  static const routeName = 'download_file';
  const DownloadFileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DownloadFileScreenState();
  }
}

class _DownloadFileScreenState extends State<DownloadFileScreen> {

  DownloadFileBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<DownloadFileBloc>();
    _bloc?.add(DownloadFileInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download File'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: MyButton(
        title: 'Download File',
        onPressed: () {
          if (Platform.isAndroid) {
            _bloc?.add(DownloadFileStartAndroidEvent());
          } else {
            _bloc?.add(DownloadFileStartIOSEvent());
          }
        },
      ),
    );
  }
}

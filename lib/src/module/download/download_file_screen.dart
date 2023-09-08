import 'package:flutter/material.dart';

class DownloadFileScreen extends StatefulWidget {
  static const routeName = 'download_file';
  const DownloadFileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DownloadFileScreenState();
  }
}

class _DownloadFileScreenState extends State<DownloadFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download File'),
      ),
      body: SafeArea(
        child: Text('Download File'),
      ),
    );
  }
}

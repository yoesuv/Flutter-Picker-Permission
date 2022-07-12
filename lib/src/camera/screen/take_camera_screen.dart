import 'package:flutter/material.dart';

class TakeCameraScreen extends StatefulWidget {
  const TakeCameraScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeCameraScreenState();
  }
}

class _TakeCameraScreenState extends State<TakeCameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Camera'),
      ),
      body: Center(
        child: Text('Take Camera'),
      ),
    );
  }
}
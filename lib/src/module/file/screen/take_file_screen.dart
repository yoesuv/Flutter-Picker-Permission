import 'package:flutter/material.dart';

class TakeFileScreen extends StatefulWidget {
  const TakeFileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeFileScreenState();
  }
}

class _TakeFileScreenState extends State<TakeFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take File'),
      ),
      body: Center(
        child: Text('Take File'),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TakeGalleryScreen extends StatefulWidget {
  static const routeName = 'take_gallery';
  const TakeGalleryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeGalleryScreenState();
  }
}

class _TakeGalleryScreenState extends State<TakeGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Gallery'),
      ),
      body: Center(
        child: Text('Take Gallery'),
      ),
    );
  }
}
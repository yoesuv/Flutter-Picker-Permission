import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/gallery/bloc/take_gallery_bloc.dart';

class TakeGalleryScreen extends StatefulWidget {
  static const routeName = 'take_gallery';
  const TakeGalleryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeGalleryScreenState();
  }
}

class _TakeGalleryScreenState extends State<TakeGalleryScreen> {
  late TakeGalleryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TakeGalleryBloc>();
  }

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
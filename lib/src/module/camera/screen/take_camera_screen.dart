import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/camera/bloc/take_camera_bloc.dart';

class TakeCameraScreen extends StatefulWidget {
  static const routeName = 'take_camera';
  const TakeCameraScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeCameraScreenState();
  }
}

class _TakeCameraScreenState extends State<TakeCameraScreen> {
  late TakeCameraBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TakeCameraBloc>();
  }

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

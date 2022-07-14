import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/camera/bloc/take_camera_bloc.dart';
import 'package:flutter_picker/src/module/camera/event/take_camera_event.dart';
import 'package:flutter_picker/src/module/camera/state/take_camera_state.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              const SizedBox(height: 16),
              _buildTextPath(),
              const SizedBox(height: 16),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return BlocBuilder<TakeCameraBloc, TakeCameraState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Container(),
        );
      },
    );
  }

  Widget _buildTextPath() {
    return BlocBuilder<TakeCameraBloc, TakeCameraState>(
      buildWhen: (previous, current) => previous.path != current.path,
      builder: (context, state) {
        return Text('${state.path}');
      },
    );
  }

  Widget _buildButton() {
    return Center(
      child: MyButton(
        title: 'OPEN CAMERA',
        onPressed: () {
          _bloc.add(TakeCameraOpenEvent());
        },
      ),
    );
  }
}

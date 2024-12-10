import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/gallery/bloc/take_gallery_bloc.dart';
import 'package:flutter_picker/src/module/gallery/event/take_gallery_event.dart';
import 'package:flutter_picker/src/module/gallery/state/take_gallery_state.dart';
import 'package:flutter_picker/src/utils/app_util.dart';
import 'package:flutter_picker/src/widgets/dialog_open_app_settings.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';
import 'package:permission_handler/permission_handler.dart';

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
      body: BlocListener<TakeGalleryBloc, TakeGalleryState>(
        bloc: _bloc,
        listenWhen: (previous, current) =>
            previous.permissionStatus != current.permissionStatus,
        listener: (context, state) {
          if (state.permissionStatus != null) {
            if (state.permissionStatus != PermissionStatus.granted) {
              showErrorSnackBar(
                context,
                'Permission ${state.permissionStatus?.name}',
              );
              showDialog(
                context: context,
                builder: (context) {
                  return const DialogOpenAppSettings();
                },
              );
            }
          }
        },
        child: SafeArea(
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
      ),
    );
  }

  Widget _buildImage() {
    return BlocBuilder<TakeGalleryBloc, TakeGalleryState>(
      bloc: _bloc,
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: state.file != null
              ? Image.file(
                  state.file!,
                  fit: BoxFit.cover,
                )
              : Container(),
        );
      },
    );
  }

  Widget _buildTextPath() {
    return BlocBuilder<TakeGalleryBloc, TakeGalleryState>(
      bloc: _bloc,
      buildWhen: (previous, current) => previous.path != current.path,
      builder: (context, state) {
        return Text('${state.path}');
      },
    );
  }

  Widget _buildButton() {
    return Center(
      child: MyButton(
        title: 'OPEN GALLERY',
        onPressed: () {
          if (Platform.isAndroid) {
            _bloc.add(TakeGalleryOpenAndroidEvent());
          } else {
            _bloc.add(TakeGalleryOpenIosEvent());
          }
        },
      ),
    );
  }
}

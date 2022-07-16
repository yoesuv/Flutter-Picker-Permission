import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/camera/event/take_camera_event.dart';
import 'package:flutter_picker/src/module/camera/state/take_camera_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeCameraBloc extends Bloc<TakeCameraEvent, TakeCameraState> {
  TakeCameraBloc() : super(const TakeCameraState()) {
    on<TakeCameraOpenEvent>(_openCamera);
  }

  void _openCamera(
    TakeCameraOpenEvent event,
    Emitter<TakeCameraState> emit,
  ) async {
    final status = await Permission.camera.status;
    if (status == PermissionStatus.granted) {
      final pickedImage = await _pickFromCamera();
      if (pickedImage != null) {
        emit(state.copyWith(
          path: pickedImage.path,
          file: File(pickedImage.path),
        ));
      }
    } else {
      final request = await Permission.camera.request();
      if (request == PermissionStatus.granted) {
        final pickedImage = await _pickFromCamera();
        if (pickedImage != null) {
          emit(state.copyWith(
            path: pickedImage.path,
            file: File(pickedImage.path),
          ));
        }
      } else {
        emit(state.copyWith(permissionStatus: null));
        emit(state.copyWith(permissionStatus: request));
      }
    }
  }

  Future<XFile?> _pickFromCamera() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }
}

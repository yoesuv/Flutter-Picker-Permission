import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/gallery/event/take_gallery_event.dart';
import 'package:flutter_picker/src/module/gallery/state/take_gallery_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeGalleryBloc extends Bloc<TakeGalleryEvent, TakeGalleryState> {
  TakeGalleryBloc() : super(const TakeGalleryState()) {
    on<TakeGalleryOpenEvent>(_openGallery);
  }

  void _openGallery(
    TakeGalleryOpenEvent event,
    Emitter<TakeGalleryState> emit,
  ) async {
    late Permission permission;
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      debugPrint('Take Gallery Bloc # android sdk int $sdkInt');
      if (sdkInt >= 33) {
        permission = Permission.photos;
      } else {
        permission = Permission.storage;
      }
    } else {
      permission = Permission.photos;
    }
    debugPrint('Take Gallery Bloc # permission $permission');
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      final pickedImage = await _pickFromGallery();
      if (pickedImage != null) {
        emit(state.copyWith(
          file: File(pickedImage.path),
          path: pickedImage.path,
        ));
      }
    } else {
      final request = await permission.request();
      if (request == PermissionStatus.granted) {
        final pickedImage = await _pickFromGallery();
        if (pickedImage != null) {
          emit(state.copyWith(
            file: File(pickedImage.path),
            path: pickedImage.path,
          ));
        }
      } else {
        emit(state.copyWith(permissionStatus: null));
        emit(state.copyWith(permissionStatus: request));
      }
    }
  }

  Future<XFile?> _pickFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}

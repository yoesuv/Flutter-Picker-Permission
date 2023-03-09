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
    on<TakeGalleryOpenAndroidEvent>(_openGalleryAndroid);
    on<TakeGalleryOpenIosEvent>(_openGalleryIos);
  }

  void _openGalleryAndroid(
    TakeGalleryOpenAndroidEvent event,
    Emitter<TakeGalleryState> emit,
  ) async {
    late Permission permission;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;
    debugPrint('Take Gallery Bloc # android sdk int $sdkInt');

    if (sdkInt >= 33) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }

    debugPrint('Take Gallery Bloc # permission $permission');
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      await _setSelectedImage(emit);
    } else {
      final request = await permission.request();
      if (request == PermissionStatus.granted) {
        await _setSelectedImage(emit);
      } else {
        emit(state.copyWith(permissionStatus: null));
        emit(state.copyWith(permissionStatus: request));
      }
    }
  }

  void _openGalleryIos(
    TakeGalleryOpenIosEvent event,
    Emitter<TakeGalleryState> emit,
  ) async {
    const permission = Permission.photos;
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      await _setSelectedImage(emit);
    } else {
      final request = await permission.request();
      debugPrint('Take Gallery Bloc # request gallery result : $request');
      if (request == PermissionStatus.granted) {
        await _setSelectedImage(emit);
      } else {
        emit(state.copyWith(permissionStatus: null));
        emit(state.copyWith(permissionStatus: request));
      }
    }
  }

  Future<void> _setSelectedImage(Emitter<TakeGalleryState> emit) async {
    final pickedImage = await ImagePicker().pickImage(
      requestFullMetadata: false,
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      emit(state.copyWith(
        file: File(pickedImage.path),
        path: pickedImage.path,
      ));
    }
  }
}

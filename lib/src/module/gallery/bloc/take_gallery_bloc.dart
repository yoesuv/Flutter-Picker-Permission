import 'dart:io';

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
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        final pickedImage = await _pickFromGallery();
        if (pickedImage != null) {
          emit(state.copyWith(
            file: File(pickedImage.path),
            path: pickedImage.path,
          ));
        }
      } else {
        final request = await Permission.storage.request();
        if (request == PermissionStatus.granted) {
          final pickedImage = await _pickFromGallery();
          emit(state.copyWith(
            file: File(pickedImage!.path),
            path: pickedImage.path,
          ));
        } else {
          debugPrint('TakeGalleryBloc # android request permission status DENIED');
        }
      }
    }
  }

  Future<XFile?> _pickFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

}

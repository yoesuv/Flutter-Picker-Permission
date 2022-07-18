import 'dart:io';

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
    late Permission permission = Permission.storage;
    if (Platform.isIOS) {
      permission = Permission.photos;
    }
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

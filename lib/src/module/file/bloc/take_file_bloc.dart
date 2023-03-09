import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/file/event/take_file_event.dart';
import 'package:flutter_picker/src/module/file/state/take_file_state.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeFileBloc extends Bloc<TakeFileEvent, TakeFileState> {
  TakeFileBloc() : super(const TakeFileState()) {
    on<TakeFileAndroidChooseEvent>(_openFilePickerAndroid);
    on<TakeFileIosChooseEvent>(_openFilePickerIos);
  }

  void _openFilePickerAndroid(
    TakeFileAndroidChooseEvent event,
    Emitter<TakeFileState> emit,
  ) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;
    debugPrint('TakeFileBloc # android sdk int $sdkInt');
    if (sdkInt >= 33) {
      await _pickFile(emit);
    } else {
      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        await _pickFile(emit);
      } else {
        final request = await Permission.storage.request();
        if (request == PermissionStatus.granted) {
          await _pickFile(emit);
        } else {
          emit(state.copyWith(permissionStatus: null));
          emit(state.copyWith(permissionStatus: request));
        }
      }
    }
  }

  void _openFilePickerIos(
    TakeFileIosChooseEvent event,
    Emitter<TakeFileState> emit,
  ) async {
    final status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      await _pickFile(emit);
    } else {
      final request = await Permission.storage.request();
      if (request == PermissionStatus.granted) {
        await _pickFile(emit);
      } else {
        emit(state.copyWith(permissionStatus: null));
        emit(state.copyWith(permissionStatus: request));
      }
    }
  }

  Future<void> _pickFile(Emitter<TakeFileState> emit) async {
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.any);
    if (pickedFile != null) {
      emit(state.copyWith(
        path: pickedFile.files.first.path,
      ));
    }
  }

}

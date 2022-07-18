import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/file/event/take_file_event.dart';
import 'package:flutter_picker/src/module/file/state/take_file_state.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeFileBloc extends Bloc<TakeFileEvent, TakeFileState> {
  TakeFileBloc() : super(const TakeFileState()) {
    on<TakeFileChooseEvent>(_openFilePicker);
  }

  void _openFilePicker(
    TakeFileChooseEvent event,
    Emitter<TakeFileState> emit,
  ) async {
    final status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      final pickedFile = await _pickFiles();
      if (pickedFile != null) {
        emit(state.copyWith(
          path: pickedFile.files.first.path,
        ));
      }
    } else {
      final request = await Permission.storage.request();
      if (request == PermissionStatus.granted) {
        final pickedFile = await _pickFiles();
        if (pickedFile != null) {
          emit(state.copyWith(
            path: pickedFile.files.first.path,
          ));
        }
      } else {
        emit(state.copyWith(permissionStatus: null));
        emit(state.copyWith(permissionStatus: request));
      }
    }
  }

  Future<FilePickerResult?> _pickFiles() async {
    return await FilePicker.platform.pickFiles(type: FileType.any);
  }
}

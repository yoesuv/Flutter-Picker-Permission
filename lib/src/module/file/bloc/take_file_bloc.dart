import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/file/event/take_file_event.dart';
import 'package:flutter_picker/src/module/file/state/take_file_state.dart';

class TakeFileBloc extends Bloc<TakeFileEvent, TakeFileState> {
  TakeFileBloc() : super(const TakeFileState()) {
    on<TakeFileChooseEvent>(_openFilePicker);
  }

  void _openFilePicker(
    TakeFileChooseEvent event,
    Emitter<TakeFileState> emit,
  ) {
    debugPrint('TakeFileBloc # open file picker');
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';

class RecordAudioBloc extends Bloc<RecordAudioEvent, RecordAudioState> {
  RecordAudioBloc() : super(const RecordAudioState()) {
    on<RecordAudioInitEvent>(_onInit);
    on<RecordAudioStartEvent>(_onStart);
    on<RecordAudioStopEvent>(_onStop);
  }

  void _onInit(
    RecordAudioInitEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      isRecording: false,
    ));
  }

  void _onStart(
    RecordAudioStartEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      isRecording: true,
    ));
  }

  void _onStop(
    RecordAudioStopEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      isRecording: false,
    ));
  }
}

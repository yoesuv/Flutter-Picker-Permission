import 'package:equatable/equatable.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:pausable_timer/pausable_timer.dart';

abstract class RecordAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecordAudioInitEvent extends RecordAudioEvent {}

class RecordAudioStateEvent extends RecordAudioEvent {
  RecordAudioStateEvent({
    this.recordingState = RecordingState.start,
    this.timer,
  });

  final RecordingState recordingState;
  final PausableTimer? timer;

  @override
  List<Object?> get props => [
        recordingState,
        timer,
      ];
}

class RecordAudioTimerEvent extends RecordAudioEvent {}

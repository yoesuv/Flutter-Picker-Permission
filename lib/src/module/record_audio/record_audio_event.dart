import 'package:equatable/equatable.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:pausable_timer/pausable_timer.dart';

abstract class RecordAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecordAudioInitEvent extends RecordAudioEvent {}

class RecordAudioActionEvent extends RecordAudioEvent {
  RecordAudioActionEvent({required this.action, this.timer});

  final RecordingAction action;
  final PausableTimer? timer;

  @override
  List<Object?> get props => [action, timer];
}

class RecordAudioTimerEvent extends RecordAudioEvent {}

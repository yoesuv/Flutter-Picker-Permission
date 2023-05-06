import 'package:equatable/equatable.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:just_audio/just_audio.dart';

abstract class RecordAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecordAudioInitEvent extends RecordAudioEvent {}

class RecordAudioStateEvent extends RecordAudioEvent {
  RecordAudioStateEvent({this.recordingState = RecordingState.start});
  final RecordingState recordingState;
  @override
  List<Object?> get props => [recordingState];
}

class RecordAudioPlayerPlayEvent extends RecordAudioEvent {
  RecordAudioPlayerPlayEvent({this.player});
  final AudioPlayer? player;
  @override
  List<Object?> get props => [player];
}

class RecordAudioPlayerStateEvent extends RecordAudioEvent {
  RecordAudioPlayerStateEvent({required this.playerState});
  final PlayerState playerState;
  @override
  List<Object?> get props => [playerState];
}

import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

abstract class RecordAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecordAudioInitEvent extends RecordAudioEvent {}

class RecordAudioStartEvent extends RecordAudioEvent {}

class RecordAudioPauseEvent extends RecordAudioEvent {}

class RecordAudioStopEvent extends RecordAudioEvent {}

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
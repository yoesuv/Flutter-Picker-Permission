import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

abstract class PlayerAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayerAudioInitEvent extends PlayerAudioEvent {
  PlayerAudioInitEvent({
    this.path,
    this.player,
  });
  final String? path;
  final AudioPlayer? player;
  @override
  List<Object?> get props => [
        path,
        player,
      ];
}

class PlayerAudioPlayerStateEvent extends PlayerAudioEvent {
  PlayerAudioPlayerStateEvent({this.playerState});
  final PlayerState? playerState;
  @override
  List<Object?> get props => [playerState];
}

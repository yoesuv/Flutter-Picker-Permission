import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

class PlayerAudioState extends Equatable {
  const PlayerAudioState({
    this.path,
    this.playerState,
  });

  final String? path;
  final PlayerState? playerState;

  PlayerAudioState copyWith({
    String? path,
    PlayerState? playerState,
  }) {
    return PlayerAudioState(
      path: path ?? this.path,
      playerState: playerState ?? this.playerState,
    );
  }

  @override
  List<Object?> get props => [
        path,
        playerState,
      ];
}

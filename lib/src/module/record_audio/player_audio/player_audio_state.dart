import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

class PlayerAudioState extends Equatable {
  const PlayerAudioState({
    this.path,
    this.playerState,
    this.strDuration = '',
  });

  final String? path;
  final PlayerState? playerState;
  final String? strDuration;

  PlayerAudioState copyWith({
    String? path,
    PlayerState? playerState,
    String? strDuration,
  }) {
    return PlayerAudioState(
      path: path ?? this.path,
      playerState: playerState ?? this.playerState,
      strDuration: strDuration ?? this.strDuration,
    );
  }

  @override
  List<Object?> get props => [
        path,
        playerState,
        strDuration,
      ];
}

import 'package:equatable/equatable.dart';

class PlayerAudioState extends Equatable {
  const PlayerAudioState({
    this.path,
  });

  final String? path;

  PlayerAudioState copyWith({
    String? path,
  }) {
    return PlayerAudioState(
      path: path ?? this.path,
    );
  }

  @override
  List<Object?> get props => [
        path,
      ];
}

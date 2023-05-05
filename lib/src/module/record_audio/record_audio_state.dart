import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;
  final bool isPaused;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;
  final String path;
  final PlayerState? playerState;

  const RecordAudioState({
    this.isRecording = false,
    this.isPaused = false,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
    this.path = '',
    this.playerState,
  });

  RecordAudioState copyWith({
    bool? isRecording,
    bool? isPaused,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
    String? path,
    PlayerState? playerState,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
      isPaused: isPaused ?? this.isPaused,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
      path: path ?? this.path,
      playerState: playerState ?? this.playerState,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
        isPaused,
        permissionMicStatus,
        isReadyToPlay,
        path,
        playerState,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;
  final String path;
  final PlayerState? playerState;

  const RecordAudioState({
    this.isRecording = false,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
    this.path = '',
    this.playerState,
  });

  RecordAudioState copyWith({
    bool? isRecording,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
    String? path,
    PlayerState? playerState,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
      path: path ?? this.path,
      playerState: playerState ?? this.playerState,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
        permissionMicStatus,
        isReadyToPlay,
        path,
        playerState,
      ];
}

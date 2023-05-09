import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

enum RecordingState {
  start,
  recording,
  pause,
  resume,
  stop,
}

class RecordAudioState extends Equatable {
  final RecordingState recordingState;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;
  final String path;
  final PlayerState? playerState;
  final String buttonTitle;
  final Duration? duration;
  final String strDuration;
  final DateTime? startTime;

  const RecordAudioState({
    this.recordingState = RecordingState.start,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
    this.path = '',
    this.playerState,
    this.buttonTitle = 'START',
    this.duration,
    this.strDuration = '',
    this.startTime,
  });

  RecordAudioState copyWith({
    RecordingState? recordingState,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
    String? path,
    PlayerState? playerState,
    String? buttonTitle,
    Duration? duration,
    String? strDuration,
    DateTime? startTime,
  }) {
    return RecordAudioState(
      recordingState: recordingState ?? this.recordingState,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
      path: path ?? this.path,
      playerState: playerState ?? this.playerState,
      buttonTitle: buttonTitle ?? this.buttonTitle,
      duration: duration ?? this.duration,
      strDuration: strDuration ?? this.strDuration,
      startTime: startTime ?? this.startTime,
    );
  }

  @override
  List<Object?> get props => [
        recordingState,
        permissionMicStatus,
        isReadyToPlay,
        path,
        playerState,
        buttonTitle,
        duration,
        strDuration,
        startTime,
      ];
}

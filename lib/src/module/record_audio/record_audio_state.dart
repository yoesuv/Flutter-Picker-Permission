import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Actions that the user can trigger
enum RecordingAction { start, pause, resume, stop }

/// Current recording status of the system
enum RecordingStatus { idle, recording, paused }

class RecordAudioState extends Equatable {
  final RecordingStatus status;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;
  final String path;
  final Duration? duration;
  final String strDuration;
  final DateTime? startTime;

  const RecordAudioState({
    this.status = RecordingStatus.idle,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
    this.path = '',
    this.duration,
    this.strDuration = '',
    this.startTime,
  });

  RecordAudioState copyWith({
    RecordingStatus? status,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
    String? path,
    Duration? duration,
    String? strDuration,
    DateTime? startTime,
  }) {
    return RecordAudioState(
      status: status ?? this.status,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
      path: path ?? this.path,
      duration: duration ?? this.duration,
      strDuration: strDuration ?? this.strDuration,
      startTime: startTime ?? this.startTime,
    );
  }

  @override
  List<Object?> get props => [
    status,
    permissionMicStatus,
    isReadyToPlay,
    path,
    duration,
    strDuration,
    startTime,
  ];
}

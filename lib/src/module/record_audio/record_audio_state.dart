import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;
  final String path;

  const RecordAudioState({
    this.isRecording = false,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
    this.path = '',
  });

  RecordAudioState copyWith({
    bool? isRecording,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
    String? path,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
      path: path ?? this.path,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
        permissionMicStatus,
        isReadyToPlay,
        path,
      ];
}

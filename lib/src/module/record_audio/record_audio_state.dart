import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;

  const RecordAudioState({
    this.isRecording = false,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
  });

  RecordAudioState copyWith({
    bool? isRecording,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
        permissionMicStatus,
        isReadyToPlay,
      ];
}

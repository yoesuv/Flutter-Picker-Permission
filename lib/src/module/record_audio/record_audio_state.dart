import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;
  final PermissionStatus? permissionMicStatus;

  const RecordAudioState({
    this.isRecording = false,
    this.permissionMicStatus,
  });

  RecordAudioState copyWith({
    bool? isRecording,
    PermissionStatus? permissionMicStatus,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
        permissionMicStatus,
      ];
}

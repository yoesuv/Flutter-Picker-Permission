import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;
  final PermissionStatus? permissionMicStatus;
  final bool isReadyToPlay;
  final String path;
  final ProcessingState processingState;
  final bool isPlaying;

  const RecordAudioState({
    this.isRecording = false,
    this.permissionMicStatus,
    this.isReadyToPlay = false,
    this.path = '',
    this.processingState = ProcessingState.idle,
    this.isPlaying = false,
  });

  RecordAudioState copyWith({
    bool? isRecording,
    PermissionStatus? permissionMicStatus,
    bool? isReadyToPlay,
    String? path,
    ProcessingState? processingState,
    bool? isPlaying,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
      permissionMicStatus: permissionMicStatus ?? this.permissionMicStatus,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
      path: path ?? this.path,
      processingState: processingState ?? this.processingState,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
        permissionMicStatus,
        isReadyToPlay,
        path,
        processingState,
        isPlaying,
      ];
}

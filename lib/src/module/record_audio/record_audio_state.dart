import 'package:equatable/equatable.dart';

class RecordAudioState extends Equatable {
  final bool isRecording;

  const RecordAudioState({
    this.isRecording = false,
  });

  RecordAudioState copyWith({
    bool? isRecording,
  }) {
    return RecordAudioState(
      isRecording: isRecording ?? this.isRecording,
    );
  }

  @override
  List<Object?> get props => [
        isRecording,
      ];
}

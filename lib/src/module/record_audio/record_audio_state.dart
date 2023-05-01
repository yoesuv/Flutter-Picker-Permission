import 'package:equatable/equatable.dart';

class RecordAudioState extends Equatable {
  final bool? isRecording;

  const RecordAudioState({
    this.isRecording = false,
  });

  @override
  List<Object?> get props => [
        isRecording,
      ];
}

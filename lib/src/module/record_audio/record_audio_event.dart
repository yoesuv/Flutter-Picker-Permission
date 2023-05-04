import 'package:equatable/equatable.dart';

abstract class RecordAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecordAudioInitEvent extends RecordAudioEvent {}

class RecordAudioStartEvent extends RecordAudioEvent {}

class RecordAudioStopEvent extends RecordAudioEvent {}

class RecordAudioPlayEvent extends RecordAudioEvent {}
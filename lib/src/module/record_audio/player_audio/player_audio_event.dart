import 'package:equatable/equatable.dart';

abstract class PlayerAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayerAudioInitEvent extends PlayerAudioEvent {
  PlayerAudioInitEvent({this.path = ''});
  final String? path;
  @override
  List<Object?> get props => [path];
}
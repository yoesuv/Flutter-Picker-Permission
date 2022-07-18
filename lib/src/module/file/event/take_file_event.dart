import 'package:equatable/equatable.dart';

abstract class TakeFileEvent extends Equatable {}

class TakeFileChooseEvent extends TakeFileEvent {
  @override
  List<Object?> get props => [];
}

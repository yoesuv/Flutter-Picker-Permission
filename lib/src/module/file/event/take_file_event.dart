import 'package:equatable/equatable.dart';

abstract class TakeFileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TakeFileAndroidChooseEvent extends TakeFileEvent {}

class TakeFileIosChooseEvent extends TakeFileEvent {}

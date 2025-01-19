import 'package:equatable/equatable.dart';

abstract class TakeCameraEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TakeCameraOpenEvent extends TakeCameraEvent {}

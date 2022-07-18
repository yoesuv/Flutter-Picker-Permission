import 'package:equatable/equatable.dart';

abstract class TakeCameraEvent extends Equatable {}

class TakeCameraOpenEvent extends TakeCameraEvent {
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {}

class GetLocationEvent extends LocationEvent {
  @override
  List<Object?> get props => [];
}
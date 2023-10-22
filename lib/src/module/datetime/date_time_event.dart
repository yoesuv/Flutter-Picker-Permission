import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DateTimeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DateTimeInitEvent extends DateTimeEvent {}

class DateTimeSetDateEvent extends DateTimeEvent {
  DateTimeSetDateEvent({this.dateTime});
  final DateTime? dateTime;
  @override
  List<Object?> get props => [dateTime];
}

class DateTimeSetTimeEvent extends DateTimeInitEvent {
  DateTimeSetTimeEvent({this.timeOfDay});
  final TimeOfDay? timeOfDay;
  @override
  List<Object?> get props => [timeOfDay];
}

import 'package:equatable/equatable.dart';

abstract class DateTimeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DateTimeSetDateEvent extends DateTimeEvent {
  DateTimeSetDateEvent({this.dateTime});
  final DateTime? dateTime;
  @override
  List<Object?> get props => [dateTime];
}
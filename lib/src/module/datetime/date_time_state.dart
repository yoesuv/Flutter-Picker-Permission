import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DateTimeState extends Equatable {
  const DateTimeState({
    this.selectedDate,
    this.selectedTime,
  });

  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  DateTimeState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  }) {
    return DateTimeState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
        selectedTime,
      ];
}

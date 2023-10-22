import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/datetime/date_time_event.dart';
import 'package:flutter_picker/src/module/datetime/date_time_state.dart';

class DateTimeBloc extends Bloc<DateTimeEvent, DateTimeState> {
  DateTimeBloc() : super(const DateTimeState()) {
    on<DateTimeInitEvent>(_onInit);
    on<DateTimeSetDateEvent>(_onSetDate);
    on<DateTimeSetTimeEvent>(_onSetTime);
  }

  void _onInit(
    DateTimeInitEvent event,
    Emitter<DateTimeState> emit,
  ) {
    emit(state.copyWith(
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ));
  }

  void _onSetDate(
    DateTimeSetDateEvent event,
    Emitter<DateTimeState> emit,
  ) {
    emit(state.copyWith(
      selectedDate: event.dateTime,
    ));
  }

  void _onSetTime(
    DateTimeSetTimeEvent event,
    Emitter<DateTimeState> emit,
  ) {
    emit(state.copyWith(
      selectedTime: event.timeOfDay,
    ));
  }
}

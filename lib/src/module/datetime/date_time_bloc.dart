import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/datetime/date_time_event.dart';
import 'package:flutter_picker/src/module/datetime/date_time_state.dart';

class DateTimeBloc extends Bloc<DateTimeEvent, DateTimeState> {
  DateTimeBloc() : super(const DateTimeState()) {
    on<DateTimeSetDateEvent>(_onSetDate);
    on<DateTimeInitEvent>(_onInit);
  }

  void _onInit(
    DateTimeInitEvent event,
    Emitter<DateTimeState> emit,
  ) {
    emit(state.copyWith(
      selectedDate: DateTime.now(),
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
}

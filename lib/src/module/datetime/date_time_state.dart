import 'package:equatable/equatable.dart';

class DateTimeState extends Equatable {
  const DateTimeState({
    this.selectedDate,
  });

  final DateTime? selectedDate;

  @override
  List<Object?> get props => [selectedDate];
}

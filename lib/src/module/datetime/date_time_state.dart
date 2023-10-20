import 'package:equatable/equatable.dart';

class DateTimeState extends Equatable {
  const DateTimeState({
    this.selectedDate,
  });

  final DateTime? selectedDate;

  DateTimeState copyWith({
    DateTime? selectedDate,
  }) {
    return DateTimeState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
      ];
}

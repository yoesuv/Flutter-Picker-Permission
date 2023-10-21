import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/datetime/date_time_bloc.dart';
import 'package:flutter_picker/src/module/datetime/date_time_event.dart';
import 'package:flutter_picker/src/module/datetime/date_time_state.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimeScreen extends StatefulWidget {
  static const routeName = 'date_time';
  const DateTimeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DateTimeScreenState();
  }
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  DateTimeBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<DateTimeBloc>();
    _bloc?.add(DateTimeInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Time'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSelectedDate(),
              const SizedBox(height: 8),
              _buildDefaultDate(),
              const SizedBox(height: 8),
              _buildCustomDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDate() {
    return BlocBuilder<DateTimeBloc, DateTimeState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.selectedDate != current.selectedDate,
      builder: (context, state) {
        final date = state.selectedDate;
        final day = date?.day;
        final month = date?.month;
        final year = date?.year;
        return Text(
          "Selected Date : $day/$month/$year",
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }

  Widget _buildDefaultDate() {
    return Center(
      child: MyButton(
        title: 'DEFAULT DATE PICKER',
        onPressed: () async {
          final now = DateTime.now();
          final lastDate = DateTime(now.year, now.month + 1, now.day);
          var theDate = await showDatePicker(
            context: context,
            initialDate: now,
            firstDate: now,
            lastDate: lastDate,
            initialEntryMode: DatePickerEntryMode.calendar,
          );
          if (theDate != null) {
            _bloc?.add(DateTimeSetDateEvent(dateTime: theDate));
          }
        },
      ),
    );
  }

  Widget _buildCustomDate() {
    return Center(
      child: MyButton(
        title: 'CUSTOM DATE PICKER',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SfDateRangePicker(
                headerHeight: 60,
                headerStyle: const DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ),
                selectionMode: DateRangePickerSelectionMode.single,
                showNavigationArrow: true,
                showActionButtons: true,
                selectionRadius: 20,
                selectionTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onCancel: () => Navigator.pop(context),
                onSubmit: (value) {
                  final theDate = value as DateTime;
                  _bloc?.add(DateTimeSetDateEvent(dateTime: theDate));
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/datetime/date_time_bloc.dart';
import 'package:flutter_picker/src/module/datetime/date_time_event.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

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
              _buildDefaultDate(),
            ],
          ),
        ),
      ),
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
}

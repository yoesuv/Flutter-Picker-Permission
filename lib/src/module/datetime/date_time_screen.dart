import 'package:flutter/material.dart';

class DateTimeScreen extends StatefulWidget {
  static const routeName = 'date_time';
  const DateTimeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DateTimeScreenState();
  }
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Time'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Date Time Picker'),
        ),
      ),
    );
  }
}
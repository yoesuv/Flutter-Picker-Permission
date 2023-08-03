import 'package:flutter/material.dart';

class PushNotificationScreen extends StatefulWidget {
  static const routeName = 'push_notification';
  const PushNotificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PushNotificationScreenState();
  }
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notification'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Push Notification'),
        ),
      ),
    );
  }
}

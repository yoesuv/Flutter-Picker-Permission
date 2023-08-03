import 'package:flutter/material.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: MyButton(
                  title: 'LOCAL NOTIFICATION',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

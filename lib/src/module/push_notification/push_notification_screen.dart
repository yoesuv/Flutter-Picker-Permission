import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_bloc.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_event.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_state.dart';
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
  PushNotificationBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<PushNotificationBloc>();
    _bloc?.add(PushNotificationInitEvent());
  }

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
              _buildPermission(),
              const SizedBox(height: 16),
              Center(
                child: MyButton(
                  title: 'LOCAL NOTIFICATION',
                  onPressed: () {
                    _bloc?.add(PushNotificationLocalEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermission() {
    return Center(
      child: BlocBuilder<PushNotificationBloc, PushNotificationState>(
        bloc: _bloc,
        buildWhen: (prev, current) =>
            prev.permissionPushStatus != current.permissionPushStatus,
        builder: (context, state) => Text(
          'Notification Permission : ${state.permissionPushStatus?.name.toUpperCase()}',
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

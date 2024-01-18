import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_event.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';

class PushNotificationBloc
    extends Bloc<PushNotificationEvent, PushNotificationState> {

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  PushNotificationBloc() : super(const PushNotificationState()) {
    on<PushNotificationInitEvent>(_init);
    on<PushNotificationLocalEvent>(_showPushNotificationLocal);
  }

  void _init(
    PushNotificationInitEvent event,
    Emitter<PushNotificationState> emit,
  ) async {
    // setup notifications
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // check device
    final ringerStatus = await SoundMode.ringerModeStatus;

    emit(state.copyWith(
      permissionPushStatus: await Permission.notification.status,
      ringerModeStatus: ringerStatus,
    ));
  }

  void _showPushNotificationLocal(
    PushNotificationLocalEvent event,
    Emitter<PushNotificationState> emit,
  ) async {
    final result = await Permission.notification.request();
    emit(state.copyWith(
      permissionPushStatus: result,
    ));
    if (result == PermissionStatus.granted) {
        const androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'channel_id',
          'Push Local Notification',
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.deepPurple,
        );
        const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
        const platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics,
        );
        await flutterLocalNotificationsPlugin.show(
          0,
          "This is title",
          "Lorem ipsum dolor amit",
          platformChannelSpecifics,
          payload: null,
        );
    } else {
      debugPrint("PushNotificationBloc # permission DENIED or else");
    }
  }

}

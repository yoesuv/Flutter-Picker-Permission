import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_event.dart';
import 'package:flutter_picker/src/module/push_notification/push_notification_state.dart';
import 'package:permission_handler/permission_handler.dart';

class PushNotificationBloc
    extends Bloc<PushNotificationEvent, PushNotificationState> {
  PushNotificationBloc() : super(const PushNotificationState()) {
    on<PushNotificationInitEvent>(_init);
    on<PushNotificationLocalEvent>(_showPushNotificationLocal);
  }

  void _init(
    PushNotificationInitEvent event,
    Emitter<PushNotificationState> emit,
  ) async {
    emit(state.copyWith(
      permissionPushStatus: await Permission.notification.status,
    ));
  }

  void _showPushNotificationLocal(
    PushNotificationLocalEvent event,
    Emitter<PushNotificationState> emit,
  ) {
    debugPrint("PushNotificationBloc # _showPushNotificationLocal");
    if (Platform.isAndroid) {
    } else {}
  }
}

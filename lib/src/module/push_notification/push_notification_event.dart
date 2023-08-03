import 'package:equatable/equatable.dart';

abstract class PushNotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PushNotificationInitEvent extends PushNotificationEvent {}

class PushNotificationLocalEvent extends PushNotificationEvent {}

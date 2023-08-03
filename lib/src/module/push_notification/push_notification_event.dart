import 'package:equatable/equatable.dart';

abstract class PushNotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PushNotificationLocalEvent extends PushNotificationEvent {}

import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class PushNotificationState extends Equatable {
  const PushNotificationState({
    this.permissionPushStatus,
  });

  final PermissionStatus? permissionPushStatus;

  PushNotificationState copyWith({
    PermissionStatus? permissionPushStatus,
  }) {
    return PushNotificationState(
      permissionPushStatus: permissionPushStatus ?? this.permissionPushStatus,
    );
  }

  @override
  List<Object?> get props => [
        permissionPushStatus,
      ];
}

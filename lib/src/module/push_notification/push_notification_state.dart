import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class PushNotificationState extends Equatable {
  const PushNotificationState({
    this.permissionPushStatus,
    this.ringerModeStatus = RingerModeStatus.unknown,
  });

  final PermissionStatus? permissionPushStatus;
  final RingerModeStatus? ringerModeStatus;

  PushNotificationState copyWith({
    PermissionStatus? permissionPushStatus,
    RingerModeStatus? ringerModeStatus,
  }) {
    return PushNotificationState(
      permissionPushStatus: permissionPushStatus ?? this.permissionPushStatus,
      ringerModeStatus: ringerModeStatus ?? this.ringerModeStatus,
    );
  }

  @override
  List<Object?> get props => [
        permissionPushStatus,
        ringerModeStatus,
      ];
}

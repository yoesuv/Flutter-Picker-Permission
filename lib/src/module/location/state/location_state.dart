import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationState extends Equatable {
  final PermissionStatus? permissionStatus;
  final String? strLatLng;

  const LocationState({
    this.permissionStatus,
    this.strLatLng,
  });

  LocationState copyWith({
    PermissionStatus? status,
    String? strLatLng,
  }) {
    return LocationState(
      permissionStatus: status,
      strLatLng: strLatLng ?? this.strLatLng,
    );
  }

  @override
  List<Object?> get props => [
        permissionStatus,
        strLatLng,
      ];
}

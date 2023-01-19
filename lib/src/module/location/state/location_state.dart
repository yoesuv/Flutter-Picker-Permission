import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationState extends Equatable {
  final bool? locationService;
  final PermissionStatus? permissionStatus;
  final String? strLatLng;

  const LocationState({
    this.locationService = true,
    this.permissionStatus,
    this.strLatLng = '',
  });

  LocationState copyWith({
    bool? locationService,
    PermissionStatus? status,
    String? strLatLng,
  }) {
    return LocationState(
      locationService: locationService,
      permissionStatus: status,
      strLatLng: strLatLng ?? this.strLatLng,
    );
  }

  @override
  List<Object?> get props => [
        locationService,
        permissionStatus,
        strLatLng,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationState extends Equatable {
  final bool isLoading;
  final bool? locationService;
  final PermissionStatus? permissionStatus;
  final String? strLatLng;
  final String? errorMessage;

  const LocationState({
    this.isLoading = false,
    this.locationService = true,
    this.permissionStatus,
    this.strLatLng = '',
    this.errorMessage,
  });

  LocationState copyWith({
    bool? isLoading,
    bool? locationService,
    PermissionStatus? permissionStatus,
    String? strLatLng,
    String? errorMessage,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      locationService: locationService,
      permissionStatus: permissionStatus,
      strLatLng: strLatLng ?? this.strLatLng,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    locationService,
    permissionStatus,
    strLatLng,
    errorMessage,
  ];
}

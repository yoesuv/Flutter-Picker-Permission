import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/location/event/location_event.dart';
import 'package:flutter_picker/src/module/location/state/location_state.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LocationBloc() : super(const LocationState()) {
    on<GetLocationEvent>(_onGetLocation);
  }

  void _onGetLocation(
    GetLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    debugPrint('Location Bloc # get user location');
    emit(state.copyWith(
      locationService: null,
    ));
    //final checkService = await isGPSEnabled();
    final checkService = true;
    if (checkService) {
      const permission = handler.Permission.location;
      final permissionStatus = await permission.request();
      if (permissionStatus == handler.PermissionStatus.granted) {
        await _getUserLocation(emit);
      } else {
        final request = await permission.request();
        if (request == handler.PermissionStatus.granted) {
          await _getUserLocation(emit);
        } else {
          emit(state.copyWith(status: null));
          emit(state.copyWith(status: request));
        }
      }
    } else {
      emit(state.copyWith(
        locationService: checkService,
      ));
    }
  }

  Future<void> _getUserLocation(Emitter<LocationState> emit) async {
    /*final locationData = await getLocation(settings: LocationSettings(
      askForPermission: true,
      askForGPS: true,
      fallbackToGPS: true,
      askForGooglePlayServices: true,
      useGooglePlayServices: true,
    ));
    final strLatLng = '${locationData.latitude}, ${locationData.longitude}';
    emit(state.copyWith(
      strLatLng: strLatLng,
    ));*/
  }
}

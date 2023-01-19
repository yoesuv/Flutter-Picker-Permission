import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/location/event/location_event.dart';
import 'package:flutter_picker/src/module/location/state/location_state.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LocationBloc() : super(const LocationState()) {
    on<GetLocationEvent>(_onGetLocation);
  }

  void _onGetLocation(GetLocationEvent event, Emitter<LocationState> emit) async {
    debugPrint('Location Bloc # get user location');
    const permission = Permission.location;
    final permissionStatus = await permission.request();
    if (permissionStatus == PermissionStatus.granted) {

    } else {
      final request = await permission.request();
      if (request == PermissionStatus.granted) {

      } else {
        emit(state.copyWith(status: null));
        emit(state.copyWith(status: request));
      }
    }
  }

}
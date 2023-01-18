import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/location/event/location_event.dart';
import 'package:flutter_picker/src/module/location/state/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LocationBloc() : super(const LocationState()) {
    on<GetLocationEvent>(_onGetLocation);
  }

  void _onGetLocation(GetLocationEvent event, Emitter<LocationState> emit) {
    debugPrint('Location Bloc # get user location');
  }

}
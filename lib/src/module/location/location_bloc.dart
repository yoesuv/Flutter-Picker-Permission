import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/location/location_event.dart';
import 'package:flutter_picker/src/module/location/location_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<GetLocationEvent>(_onGetLocation);
  }

  void _onGetLocation(
    GetLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        locationService: null,
        errorMessage: null,
      ),
    );

    try {
      final checkService = await Geolocator.isLocationServiceEnabled();

      if (!checkService) {
        emit(state.copyWith(isLoading: false, locationService: false));
        return;
      }

      emit(state.copyWith(locationService: true));

      final permission = handler.Permission.location;
      final permissionStatus = await permission.status;

      if (permissionStatus == handler.PermissionStatus.granted) {
        await _getUserLocation(emit);
      } else {
        final requestResult = await permission.request();

        if (requestResult == handler.PermissionStatus.granted) {
          await _getUserLocation(emit);
        } else {
          emit(
            state.copyWith(isLoading: false, permissionStatus: requestResult),
          );
        }
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getUserLocation(Emitter<LocationState> emit) async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final strLatLng = '${position.latitude}, ${position.longitude}';
      emit(state.copyWith(isLoading: false, strLatLng: strLatLng));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to get location: $e',
        ),
      );
    }
  }
}

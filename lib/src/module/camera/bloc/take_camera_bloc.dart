import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/camera/event/take_camera_event.dart';
import 'package:flutter_picker/src/module/camera/state/take_camera_state.dart';

class TakeCameraBloc extends Bloc<TakeCameraEvent, TakeCameraState> {
  TakeCameraBloc() : super(const TakeCameraState()) {
    on<TakeCameraOpenEvent>(_openCamera);
  }

  void _openCamera(
    TakeCameraOpenEvent event,
    Emitter<TakeCameraState> emit,
  ) {}
}

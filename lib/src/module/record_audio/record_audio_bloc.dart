import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class RecordAudioBloc extends Bloc<RecordAudioEvent, RecordAudioState> {
  RecordAudioBloc() : super(const RecordAudioState()) {
    on<RecordAudioInitEvent>(_onInit);
    on<RecordAudioStartEvent>(_onStart);
    on<RecordAudioStopEvent>(_onStop);
  }

  void _onInit(
    RecordAudioInitEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      isRecording: false,
    ));
  }

  void _onStart(
    RecordAudioStartEvent event,
    Emitter<RecordAudioState> emit,
  ) async {
    if (Platform.isAndroid) {
      // for android
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 33) {
        final checkMicStatus = await Permission.microphone.status;
        debugPrint('RecordAudioBloc # mic status $checkMicStatus');
        emit(state.copyWith(
          permissionMicStatus: checkMicStatus,
        ));
        if (checkMicStatus == PermissionStatus.granted) {
          await _startRecording(emit);
        } else {
          final request = await Permission.microphone.request();
          emit(state.copyWith(
            permissionMicStatus: request,
          ));
          if (request == PermissionStatus.granted) {
            await _startRecording(emit);
          }
        }
      }
    } else {
      // for ios
      emit(state.copyWith(
        isRecording: true,
      ));
    }
  }

  void _onStop(
    RecordAudioStopEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      isRecording: false,
    ));
  }

  Future<void> _startRecording(
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(
      isRecording: true,
    ));
  }
}

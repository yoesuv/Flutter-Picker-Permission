import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/core/data/constants.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:record/record.dart';

class RecordAudioBloc extends Bloc<RecordAudioEvent, RecordAudioState> {
  final record = Record();
  RecordAudioBloc() : super(const RecordAudioState()) {
    on<RecordAudioInitEvent>(_onInit);
    on<RecordAudioStateEvent>(_onRecording);
    on<RecordAudioTimerEvent>(_onTimer);
  }

  void _onInit(
    RecordAudioInitEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      recordingState: RecordingState.start,
      isReadyToPlay: false,
      buttonTitle: 'START',
      startTime: DateTime.utc(0),
    ));
  }

  void _onRecording(
    RecordAudioStateEvent event,
    Emitter<RecordAudioState> emit,
  ) async {
    final recordingState = event.recordingState;
    switch (recordingState) {
      case RecordingState.start:
        if (Platform.isAndroid) {
          // for android
          final deviceInfo = DeviceInfoPlugin();
          final androidInfo = await deviceInfo.androidInfo;
          final sdkInt = androidInfo.version.sdkInt;

          if (sdkInt >= 33) {
            final checkMicStatus = await Permission.microphone.status;
            emit(state.copyWith(
              permissionMicStatus: checkMicStatus,
            ));
            if (checkMicStatus == PermissionStatus.granted) {
              await _startRecording(emit, event.timer);
            } else {
              final request = await Permission.microphone.request();
              emit(state.copyWith(
                permissionMicStatus: request,
              ));
              if (request == PermissionStatus.granted) {
                await _startRecording(emit, event.timer);
              }
            }
          } else {
            debugPrint('RecordAudioBloc # request mic & write storage');
            Map<Permission, PermissionStatus> statuses = await [
              Permission.microphone,
              Permission.storage,
            ].request();
            final checkMicStatus = statuses[Permission.microphone];
            final checkStorageStatus = statuses[Permission.storage];
            debugPrint('RecordAudioBloc # mic status $checkMicStatus');
            debugPrint('RecordAudioBloc # storage status $checkStorageStatus');
            if (checkMicStatus == PermissionStatus.granted) {
              if (checkStorageStatus == PermissionStatus.granted) {
                await _startRecording(emit, event.timer);
              }
            }
          }
        } else {
          // for ios
          emit(state.copyWith(
            recordingState: RecordingState.stop,
            isReadyToPlay: false,
          ));
        }
        break;
      case RecordingState.recording:
        emit(state.copyWith(buttonTitle: 'PAUSE'));
        break;
      case RecordingState.pause:
        event.timer?.pause();
        bool isRecording = await record.isRecording();
        if (isRecording) {
          await record.pause();
          emit(state.copyWith(
            recordingState: RecordingState.pause,
            buttonTitle: 'RESUME',
          ));
        }
        break;
      case RecordingState.resume:
        event.timer?.start();
        bool isRecording = await record.isRecording();
        if (isRecording) {
          await record.resume();
          emit(state.copyWith(
            recordingState: RecordingState.recording,
            buttonTitle: 'PAUSE',
          ));
        }
        break;
      case RecordingState.stop:
        event.timer?.pause();
        bool isRecording = await record.isRecording();
        if (isRecording) {
          final theFile = await record.stop();
          debugPrint('RecordAudioBloc # stop recording -> final $theFile');
          emit(state.copyWith(
            recordingState: RecordingState.stop,
            isReadyToPlay: true,
            path: theFile,
            buttonTitle: 'START',
          ));
        }
        break;
    }
  }

  void _onTimer(
    RecordAudioTimerEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    final time = state.startTime ?? DateTime.utc(0);
    emit(state.copyWith(
      startTime: time.add(timerDuration),
    ));
  }

  Future<void> _startRecording(
    Emitter<RecordAudioState> emit,
    PausableTimer? timer,
  ) async {
    emit(state.copyWith(
      startTime: DateTime.utc(0),
    ));
    timer?.start();
    emit(
      state.copyWith(
        recordingState: RecordingState.recording,
        isReadyToPlay: false,
        path: '',
        buttonTitle: 'PAUSE',
      ),
    );
    Directory dir = await getTemporaryDirectory();
    await record.start(
      path: '${dir.path}/file_recording.m4a',
      encoder: AudioEncoder.aacLc,
      bitRate: 128000,
      samplingRate: 44100,
    );
  }
}

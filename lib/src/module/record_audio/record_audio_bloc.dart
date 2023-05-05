import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:record/record.dart';

class RecordAudioBloc extends Bloc<RecordAudioEvent, RecordAudioState> {
  final record = Record();
  RecordAudioBloc() : super(const RecordAudioState()) {
    on<RecordAudioInitEvent>(_onInit);
    on<RecordAudioStartEvent>(_onStart);
    on<RecordAudioPauseEvent>(_onPause);
    on<RecordAudioStopEvent>(_onStop);
    on<RecordAudioPlayerPlayEvent>(_onPlayerPlay);
    on<RecordAudioPlayerStateEvent>(_onPlayerState);
  }

  void _onInit(
    RecordAudioInitEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      isRecording: false,
      isReadyToPlay: false,
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

  void _onPause(
    RecordAudioPauseEvent event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(
      isPaused: true,
    ));
  }

  void _onStop(
    RecordAudioStopEvent event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(
      isRecording: false,
    ));
    bool isRecording = await record.isRecording();
    if (isRecording) {
      final theFile = await record.stop();
      debugPrint('RecordAudioBloc # stop recording -> final $theFile');
      emit(state.copyWith(
        isReadyToPlay: true,
        path: theFile,
      ));
    }
  }

  void _onPlayerPlay(
    RecordAudioPlayerPlayEvent event,
    Emitter<RecordAudioState> emit,
  ) async {
    try {
      await event.player?.setFilePath(state.path);
      await event.player?.play();
    } catch (e) {
      debugPrint("RecordAudioBloc # ERROR play $e");
    }
  }

  void _onPlayerState(
    RecordAudioPlayerStateEvent event,
    Emitter<RecordAudioState> emit,
  ) {
    emit(state.copyWith(
      playerState: event.playerState,
    ));
  }

  Future<void> _startRecording(
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(
      isRecording: true,
      isPaused: false,
      isReadyToPlay: false,
      path: '',
    ));
    Directory dir = await getTemporaryDirectory();
    await record.start(
      path: '${dir.path}/file_recording.m4a',
      encoder: AudioEncoder.aacLc,
      bitRate: 128000,
      samplingRate: 44100,
    );
  }
}

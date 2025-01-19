import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/core/data/constants.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';
import 'package:pausable_timer/pausable_timer.dart';

class RecordAudioScreen extends StatefulWidget {
  static const routeName = 'record_audio';
  const RecordAudioScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RecordAudioScreenState();
  }
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  PausableTimer? timer;
  RecordAudioBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RecordAudioBloc>();
    _bloc?.add(RecordAudioInitEvent());
    timer = PausableTimer(timerDuration, () {
      _bloc?.add(RecordAudioTimerEvent());
      timer?.reset();
      timer?.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Audio'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _labelStatus(),
              const SizedBox(height: 16),
              _labelTimer(),
              const SizedBox(height: 16),
              _buildButton(),
              const SizedBox(height: 32),
              _buildPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Widget _labelStatus() {
    return BlocBuilder<RecordAudioBloc, RecordAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) =>
          prev.recordingState != current.recordingState,
      builder: (context, state) => Text(
        'Is Recording : ${state.recordingState.name}',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _labelTimer() {
    return BlocBuilder<RecordAudioBloc, RecordAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.startTime != current.startTime,
      builder: (context, state) => Text(
        '${'${state.startTime?.minute ?? '00'}'.padLeft(2, '0')}:'
        '${'${state.startTime?.second ?? '00'}'.padLeft(2, '0')}',
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: BlocBuilder<RecordAudioBloc, RecordAudioState>(
        bloc: _bloc,
        buildWhen: (previous, current) =>
            previous.recordingState != current.recordingState,
        builder: (context, state) {
          return Column(
            children: [
              MyButton(
                title: state.buttonTitle,
                onPressed: () {
                  switch (state.recordingState) {
                    case RecordingState.start:
                      _bloc?.add(
                        RecordAudioStateEvent(
                          recordingState: RecordingState.start,
                          timer: timer,
                        ),
                      );
                      break;
                    case RecordingState.recording:
                      _bloc?.add(
                        RecordAudioStateEvent(
                          recordingState: RecordingState.pause,
                          timer: timer,
                        ),
                      );
                      break;
                    case RecordingState.pause:
                      _bloc?.add(
                        RecordAudioStateEvent(
                          recordingState: RecordingState.resume,
                          timer: timer,
                        ),
                      );
                      break;
                    case RecordingState.resume:
                      _bloc?.add(
                        RecordAudioStateEvent(
                          recordingState: RecordingState.resume,
                          timer: timer,
                        ),
                      );
                      break;
                    case RecordingState.stop:
                      _bloc?.add(
                        RecordAudioStateEvent(
                          recordingState: RecordingState.start,
                          timer: timer,
                        ),
                      );
                      break;
                  }
                },
              ),
              const SizedBox(height: 8),
              MyButton(
                title: 'STOP',
                onPressed: () {
                  _bloc?.add(
                    RecordAudioStateEvent(
                      recordingState: RecordingState.stop,
                      timer: timer,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayer() {
    return BlocBuilder<RecordAudioBloc, RecordAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) =>
          prev.isReadyToPlay != current.isReadyToPlay ||
          prev.path != current.path,
      builder: (context, state) {
        if (state.isReadyToPlay) {
          return PlayerAudio(path: state.path);
        }
        return Container();
      },
    );
  }
}

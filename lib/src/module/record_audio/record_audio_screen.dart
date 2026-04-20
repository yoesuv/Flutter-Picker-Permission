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
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Audio')),
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

  Widget _labelStatus() {
    return BlocBuilder<RecordAudioBloc, RecordAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.status != current.status,
      builder: (context, state) => Text(
        'Is Recording : ${state.status.name}',
        style: const TextStyle(fontSize: 16),
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
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: BlocBuilder<RecordAudioBloc, RecordAudioState>(
        bloc: _bloc,
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Column(
            children: [
              MyButton(
                title: _getButtonTitle(state.status),
                onPressed: () {
                  _handleMainButtonPress(state.status);
                },
              ),
              if (_showStopButton(state.status)) ...[
                const SizedBox(height: 8),
                MyButton(
                  title: 'STOP',
                  onPressed: () {
                    _bloc?.add(
                      RecordAudioActionEvent(
                        action: RecordingAction.stop,
                        timer: timer,
                      ),
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  String _getButtonTitle(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.idle:
        return 'START';
      case RecordingStatus.recording:
        return 'PAUSE';
      case RecordingStatus.paused:
        return 'RESUME';
    }
  }

  bool _showStopButton(RecordingStatus status) {
    return status == RecordingStatus.recording ||
        status == RecordingStatus.paused;
  }

  void _handleMainButtonPress(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.idle:
        _bloc?.add(
          RecordAudioActionEvent(action: RecordingAction.start, timer: timer),
        );
        break;
      case RecordingStatus.recording:
        _bloc?.add(
          RecordAudioActionEvent(action: RecordingAction.pause, timer: timer),
        );
        break;
      case RecordingStatus.paused:
        _bloc?.add(
          RecordAudioActionEvent(action: RecordingAction.resume, timer: timer),
        );
        break;
    }
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

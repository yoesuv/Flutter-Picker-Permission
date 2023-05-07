import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/core/constants.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';
import 'package:just_audio/just_audio.dart';
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
  final player = AudioPlayer();
  PausableTimer? timer;
  RecordAudioBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RecordAudioBloc>();
    _bloc?.add(RecordAudioInitEvent());
    player.playerStateStream.listen((streamState) {
      _bloc?.add(RecordAudioPlayerStateEvent(playerState: streamState));
    });
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
        '${'${state.startTime?.second ?? '00'}'.padLeft(2, '0')}:'
        '${'${state.startTime?.millisecond ?? '00'}'.padLeft(2, '0').substring(0, 2)}',
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
        builder: (context, state) {
          return Column(
            children: [
              MyButton(
                title: state.buttonTitle,
                onPressed: () {
                  if (state.recordingState == RecordingState.start) {
                    _bloc?.add(
                      RecordAudioStateEvent(
                        recordingState: RecordingState.start,
                        timer: timer,
                      ),
                    );
                  } else if (state.recordingState == RecordingState.recording) {
                    _bloc?.add(
                      RecordAudioStateEvent(
                        recordingState: RecordingState.pause,
                        timer: timer,
                      ),
                    );
                  } else if (state.recordingState == RecordingState.pause) {
                    _bloc?.add(
                      RecordAudioStateEvent(
                        recordingState: RecordingState.resume,
                        timer: timer,
                      ),
                    );
                  } else if (state.recordingState == RecordingState.resume) {
                    _bloc?.add(
                      RecordAudioStateEvent(
                        recordingState: RecordingState.resume,
                        timer: timer,
                      ),
                    );
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
                      player: player,
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
          prev.duration != current.duration,
      builder: (context, state) {
        if (state.isReadyToPlay) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Play Record ${state.duration}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              InkWell(
                onTap: () {
                  _bloc?.add(RecordAudioPlayerPlayEvent(player: player));
                },
                child: const Icon(Icons.play_arrow_rounded, size: 48),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

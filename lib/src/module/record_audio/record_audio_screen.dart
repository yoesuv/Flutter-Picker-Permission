import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/record_audio_state.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class RecordAudioScreen extends StatefulWidget {
  static const routeName = 'record_audio';
  const RecordAudioScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RecordAudioScreenState();
  }
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  RecordAudioBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RecordAudioBloc>();
    _bloc?.add(RecordAudioInitEvent());
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
              _buildButton(),
              const SizedBox(height: 16),
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
      builder: (context, state) => Text(
        'Is Recording : ${state.isRecording}',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: BlocBuilder<RecordAudioBloc, RecordAudioState>(
        bloc: _bloc,
        builder: (context, state) {
          return MyButton(
            title: state.isRecording ? 'STOP' : 'START',
            onPressed: () {
              if (state.isRecording) {
                _bloc?.add(RecordAudioStopEvent());
              } else {
                _bloc?.add(RecordAudioStartEvent());
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildPlayer() {
    return BlocBuilder<RecordAudioBloc, RecordAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.isReadyToPlay != current.isReadyToPlay,
      builder: (context, state) {
        if (state.isReadyToPlay) {
          return Text('Play Recording');
        }
        return Container();
      },
    );
  }
}

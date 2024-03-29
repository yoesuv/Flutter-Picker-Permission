import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_event.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_state.dart';
import 'package:just_audio/just_audio.dart';

class PlayerAudio extends StatefulWidget {
  const PlayerAudio({
    super.key,
    this.path,
  });

  final String? path;

  @override
  State<StatefulWidget> createState() {
    return _PlayerAudioState();
  }
}

class _PlayerAudioState extends State<PlayerAudio> {
  final _bloc = PlayerAudioBloc();
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _bloc.add(PlayerAudioInitEvent(path: widget.path, player: _player));
    _player.playerStateStream.listen((PlayerState state) {
      if (state.processingState == ProcessingState.completed) {
        _player.stop();
      }
      _bloc.add(PlayerAudioPlayerStateEvent(playerState: state));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _textDuration(),
        const SizedBox(height: 8),
        _playerControl(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  Widget _textDuration() {
    return BlocBuilder<PlayerAudioBloc, PlayerAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.path != current.path,
      builder: (context, state) {
        return Text(
          'Play Record ${state.strDuration}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  Widget _playerControl() {
    return BlocBuilder<PlayerAudioBloc, PlayerAudioState>(
      bloc: _bloc,
      buildWhen: (prev, current) =>
          prev.playerState != current.playerState,
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            final playing = state.playerState?.playing ?? true;
            final theState = state.playerState?.processingState;
            if (!playing && theState == ProcessingState.idle) {
              await _player.seek(Duration.zero);
              await _player.play();
            } else if (playing && theState == ProcessingState.ready) {
              await _player.pause();
            } else if (!playing && theState == ProcessingState.ready) {
              await _player.play();
            }
          },
          child: Icon(
            state.playerState?.playing == true
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            size: 64,
          ),
        );
      },
    );
  }
}

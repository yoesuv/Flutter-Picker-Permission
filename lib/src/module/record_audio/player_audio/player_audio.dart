import 'package:flutter/material.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_bloc.dart';
import 'package:flutter_picker/src/module/record_audio/player_audio/player_audio_event.dart';

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

  @override
  void initState() {
    super.initState();
    _bloc.add(PlayerAudioInitEvent(path: widget.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Play Record 01:02:46 ${widget.path}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.play_arrow_rounded, size: 48),
        ),
      ],
    );
  }
}

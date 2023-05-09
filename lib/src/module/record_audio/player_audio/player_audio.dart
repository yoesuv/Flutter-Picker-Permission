import 'package:flutter/material.dart';

class PlayerAudio extends StatelessWidget {
  const PlayerAudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Play Record 01:02:46',
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

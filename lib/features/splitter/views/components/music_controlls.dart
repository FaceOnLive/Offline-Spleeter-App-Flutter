import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'play_pause_button.dart';

class MusicControlButtons extends StatelessWidget {
  const MusicControlButtons({
    Key? key,
    required this.onPlay,
    required this.onPause,
    required this.onBackward,
    required this.onForward,
  }) : super(key: key);

  final void Function() onPlay;
  final void Function() onPause;
  final void Function() onBackward;
  final void Function() onForward;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Backward Button
        RotatedBox(
          quarterTurns: 2,
          child: IconButton(
            onPressed: onBackward,
            icon: const Icon(
              FeatherIcons.fastForward,
              color: Colors.white,
            ),
          ),
        ),

        // Play Pause Button
        PlayPauseButton(
          onPause: onPause,
          onPlay: onPlay,
        ),

        // Forward Button
        IconButton(
          onPressed: onForward,
          icon: const Icon(
            FeatherIcons.fastForward,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

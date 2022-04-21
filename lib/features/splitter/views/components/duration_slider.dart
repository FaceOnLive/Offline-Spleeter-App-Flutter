import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';

class DurationSlider extends StatelessWidget {
  const DurationSlider({
    Key? key,
    required this.playedDuration,
    required this.bufferedDuration,
    required this.onDurationChanged,
    required this.totalPlayedTime,
    required this.totalSongTime,
    required this.totalDuration,
  }) : super(key: key);

  final double playedDuration;
  final double bufferedDuration;
  final void Function(double?) onDurationChanged;
  final String totalPlayedTime;
  final String totalSongTime;
  final double totalDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // Buffered Slider
            IgnorePointer(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: SliderComponentShape.noThumb,
                ),
                child: Slider(
                  value: bufferedDuration,
                  onChanged: onDurationChanged,
                  activeColor: Colors.white30,
                  inactiveColor: Colors.black45,
                  max: 100,
                ),
              ),
            ),

            /// Progress Slider
            Slider(
              value: playedDuration,
              onChanged: onDurationChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.white70,
              max: totalDuration,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalPlayedTime,
                style: AppText(context).body1.copyWith(color: Colors.white),
              ),
              Text(
                totalSongTime,
                style: AppText(context).body1.copyWith(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';
import '../components/duration_slider.dart';
import '../components/modifer_sliders_horizontal.dart';
import '../components/music_controlls.dart';

class LoadingAudioPage extends StatelessWidget {
  const LoadingAudioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Shimmer.fromColors(
            child: const IgnorePointer(child: _MusicSplitterPageLoading()),
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade50,
          ),
        ),
        Positioned(
          bottom: AppDefaults.margin * 3,
          width: MediaQuery.of(context).size.width,
          child: Text(
            'Loading Audio...',
            style: AppText(context).headline4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class _MusicSplitterPageLoading extends StatelessWidget {
  const _MusicSplitterPageLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // Music Modifers
        _LoadingMusicModifiers(),

        //Record Button
        _LoadingTapToRecordButton(),
        Spacer(),

        /// Music Controllers
        _LoadingMusicControllers()
      ],
    );
  }
}

class _LoadingMusicControllers extends StatelessWidget {
  const _LoadingMusicControllers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppDefaults.defaultBottomSheetRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppUiBox.h10,
            DurationSlider(
              playedDuration: 0.0,
              onDurationChanged: (v) {},
              bufferedDuration: 0.0,
              totalPlayedTime: '',
              totalSongTime: '',
              totalDuration: 0.0,
            ),
            MusicControlButtons(
              onBackward: () {},
              onPause: () {},
              onPlay: () {},
              onForward: () {},
            ),
            AppUiBox.h10,
            Text(
              'Loading Audio',
              style: AppText(context).caption.copyWith(
                    color: Colors.white,
                  ),
            ),
            AppUiBox.h10,
          ],
        ));
  }
}

class _LoadingMusicModifiers extends StatelessWidget {
  const _LoadingMusicModifiers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Others,
        Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              ModifiersSliderHorizontal(
                label: 'Bass',
                icon: Icons.circle,
                onChange: (v) {},
                value: 0.0,
              ),
              ModifiersSliderHorizontal(
                label: 'Vocal',
                icon: Icons.mic,
                onChange: (v) {},
                value: 0.0,
              ),
              ModifiersSliderHorizontal(
                label: 'Drum',
                icon: Icons.music_note,
                onChange: (v) {},
                value: 0.0,
              ),
              ModifiersSliderHorizontal(
                label: 'Piano',
                icon: Icons.piano,
                onChange: (v) {},
                value: 0.0,
              ),
              ModifiersSliderHorizontal(
                label: 'Others',
                icon: Icons.devices_other_outlined,
                onChange: (v) {},
                value: 0.0,
              ),
            ],
          ),
        ),

        const Divider(),
      ],
    );
  }
}

class _LoadingTapToRecordButton extends StatelessWidget {
  const _LoadingTapToRecordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {},
          label: const Text('Tap To Record'),
          icon: const Icon(FeatherIcons.mic),
        ),
      ),
    );
  }
}

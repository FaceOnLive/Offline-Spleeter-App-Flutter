import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_defaults.dart';
import '../../../../core/constants/app_size_boxes.dart';
import '../../../../core/theme/text_theme.dart';
import '../../controllers/splitter_controller.dart';
import '../components/duration_slider.dart';
import '../components/modifer_sliders_horizontal.dart';
import '../components/music_controlls.dart';
import '../components/tap_to_record_button.dart';

/// This File Depend on Splitter Controller

class MusicSplitterPage extends StatelessWidget {
  const MusicSplitterPage({
    Key? key,
    this.controller,
  }) : super(key: key);

  final SplitterController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // Music Modifers
        MusicModifiers(),

        //Record Button
        TapToRecordButton(),
        Spacer(),

        /// Music Controllers
        MusicControllers()
      ],
    );
  }
}

class MusicControllers extends StatelessWidget {
  const MusicControllers({
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
      child: GetBuilder<SplitterController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppUiBox.h10,
              DurationSlider(
                playedDuration: controller.totalPlayedDuration.toDouble(),
                onDurationChanged: controller.onDurationSliderPressed,
                bufferedDuration: controller.totalProcessedAudio,
                totalPlayedTime: controller.totalDurationPlayedString,
                totalSongTime: controller.totalDurationString,
                totalDuration: controller.totalDurationSeconds,
              ),
              MusicControlButtons(
                onBackward: () {},
                onPause: controller.onPause,
                onPlay: controller.onPlay,
                onForward: () {},
              ),
              AppUiBox.h10,
              Text(
                controller.loadedSongName,
                style: AppText(context).caption.copyWith(
                      color: Colors.white,
                    ),
              ),
              AppUiBox.h10,
            ],
          );
        },
      ),
    );
  }
}

class MusicModifiers extends StatelessWidget {
  const MusicModifiers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplitterController>(builder: (controller) {
      return Column(
        children: [
          /// Others,
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                ModifiersSliderHorizontal(
                  label: 'Bass',
                  icon: FeatherIcons.circle,
                  onChange: (v) {
                    controller.adjustAudio(bass: v);
                  },
                  value: controller.bassLevel,
                ),
                ModifiersSliderHorizontal(
                  label: 'Vocal',
                  icon: FeatherIcons.mic,
                  onChange: (v) {
                    controller.adjustAudio(vocal: v);
                  },
                  value: controller.vocalLevel,
                ),
                ModifiersSliderHorizontal(
                  label: 'Drum',
                  icon: Icons.music_note,
                  onChange: (v) {
                    controller.adjustAudio(drum: v);
                  },
                  value: controller.drumLevel,
                ),
                ModifiersSliderHorizontal(
                  label: 'Piano',
                  icon: Icons.piano,
                  onChange: (v) {
                    controller.adjustAudio(piano: v);
                  },
                  value: controller.pianoLevel,
                ),
                ModifiersSliderHorizontal(
                  label: 'Others',
                  icon: Icons.devices_other_outlined,
                  onChange: (v) {
                    controller.adjustAudio(others: v);
                  },
                  value: controller.othersLevel,
                ),
              ],
            ),
          ),

          const Divider(),
        ],
      );
    });
  }
}

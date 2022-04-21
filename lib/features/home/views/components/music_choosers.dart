import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../core/app/controllers/core_controller.dart';
import '../../../../core/utils/app_toast.dart';

import '../../../../core/constants/constants.dart';
import 'music_selector_button.dart';

class AudioPickerTile extends StatelessWidget {
  const AudioPickerTile({
    Key? key,
    required this.onLocalButtonPressed,
    required this.onDemoButtonPressed,
  }) : super(key: key);

  final void Function() onLocalButtonPressed;
  final void Function() onDemoButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MusicSelectorButton(
              text: 'Local Songs',
              icon: FeatherIcons.music,
              onTap: () {
                controller.isDependencyLoading
                    ? AppToast.showDefaultToast(
                        'Please wait while the sdk is loading')
                    : onLocalButtonPressed();
              },
            ),
            AppUiBox.w16,
            MusicSelectorButton(
              text: 'Demo Songs',
              icon: FeatherIcons.speaker,
              onTap: () {
                controller.isDependencyLoading
                    ? AppToast.showDefaultToast(
                        'Please wait while the sdk is loading')
                    : onDemoButtonPressed();
              },
            ),
          ],
        );
      },
    );
  }
}

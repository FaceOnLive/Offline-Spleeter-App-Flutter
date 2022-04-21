import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/text_theme.dart';

class AudioFilePickerPermissionDenied extends StatelessWidget {
  const AudioFilePickerPermissionDenied({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Header(),
            // Image
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Image.asset(AppImages.illustrationError),
            ),
            // Message
            Text(
              'Files permission is needed to pick audio files, without local access the app may behave unexpectedly',
              style: AppText(context).caption,
              textAlign: TextAlign.center,
            ),
            AppUiBox.h16,

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final status = await Permission.storage.request();
                  if (status.isGranted) {
                    Get.back();
                  } else if (status.isPermanentlyDenied) {
                    openAppSettings();
                  }
                },
                child: const Text('Give Permission'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDefaults.margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Permission Is Denied',
            style: AppText(context).body1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          IconButton(
            onPressed: () => AppRoute(context).pop(),
            icon: const Icon(FeatherIcons.xCircle),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

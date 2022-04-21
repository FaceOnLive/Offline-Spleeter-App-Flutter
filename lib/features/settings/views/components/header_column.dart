import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';

class HeaderColumn extends StatelessWidget {
  const HeaderColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logo,
          width: Get.width * 0.4,
        ),
        Text(
          'Song Splitter',
          style: AppText(context).headline5.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
        AppUiBox.h10,
        Text(
          'Manipulates Music Easily',
          style: AppText(context).caption.copyWith(),
        ),
      ],
    );
  }
}

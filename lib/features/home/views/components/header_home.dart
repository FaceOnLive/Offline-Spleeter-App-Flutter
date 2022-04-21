import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppUiBox.h16,
        Image.asset(
          AppImages.logo,
          width: Get.width * 0.4,
        ),
        Text(
          'Song Splitter',
          style: AppText(context).headline5.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        AppUiBox.h10,
        Text(
          'Manipulates Music Easily',
          style: AppText(context).caption.copyWith(
                color: AppColors.white,
              ),
        )
      ],
    );
  }
}

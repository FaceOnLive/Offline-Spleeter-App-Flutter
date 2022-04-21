import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';

class MusicSelectorButton extends StatelessWidget {
  const MusicSelectorButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        elevation: 2,
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDefaults.borderRadius,
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: AppColors.primary,
                  size: 48,
                ),
                AppUiBox.h16,
                AutoSizeText(
                  text,
                  style: AppText(context).body1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                  maxLines: 1,
                  minFontSize: AppText(context).body1.fontSize!,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';

class ModifiersSliderHorizontal extends StatelessWidget {
  const ModifiersSliderHorizontal({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChange,
    required this.value,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function(double) onChange;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Slider(value: value, onChanged: onChange, max: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppUiBox.w16,
                Icon(
                  icon,
                  size: 16,
                ),
                AppUiBox.w16,
                Text(
                  label,
                  style:
                      AppText(context).body1.copyWith(color: AppColors.primary),
                ),
              ],
            ),

            // Percentage
            Row(
              children: [
                Text(
                  value.round().toString(),
                  style: AppText(context).caption.copyWith(
                        color: AppColors.primary,
                      ),
                ),
                AppUiBox.w16,
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';

class PackageSelector extends StatelessWidget {
  const PackageSelector({
    Key? key,
    required this.amount,
    required this.duration,
    this.topText,
    required this.bottomText,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String amount;
  final String duration;
  final String? topText;
  final String bottomText;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: AnimatedContainer(
                duration: AppDefaults.duration,
                padding: const EdgeInsets.all(AppDefaults.padding / 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade400,
                    width: 2,
                  ),
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (topText != null)
                      Text(
                        topText!,
                        style: AppText(context).caption,
                      ),
                    Text(
                      amount,
                      style: AppText(context).headline6.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? AppColors.primary : Colors.grey,
                          ),
                    ),
                    Text(
                      duration,
                      style: AppText(context).body1.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade400,
                          ),
                    ),
                    Text(
                      bottomText,
                      style: AppText(context).caption.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            AppUiBox.h5,
            Icon(
              FeatherIcons.checkSquare,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

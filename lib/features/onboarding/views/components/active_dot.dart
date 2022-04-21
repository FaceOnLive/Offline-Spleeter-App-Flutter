import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class ActiveDot extends StatelessWidget {
  const ActiveDot({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDefaults.duration,
      width: isActive ? 24 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey,
        borderRadius: AppDefaults.borderRadius,
      ),
    );
  }
}

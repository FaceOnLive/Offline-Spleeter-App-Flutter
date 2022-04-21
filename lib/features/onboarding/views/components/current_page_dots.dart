import 'package:flutter/material.dart';

import 'active_dot.dart';

class CurrentPageDots extends StatelessWidget {
  const CurrentPageDots({
    Key? key,
    required this.currentIndex,
    required this.totalPages,
  }) : super(key: key);

  final int currentIndex;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => ActiveDot(
          isActive: index == currentIndex,
        ),
      ),
    );
  }
}

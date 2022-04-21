import 'package:flutter/material.dart';

class AppDefaults {
  static const double radius = 18;
  static const double padding = 18;
  static const double margin = 16;

  // For Sheets
  static BorderRadius borderRadius = BorderRadius.circular(radius);

  /// Used For Bottom Sheet
  static BorderRadius defaultBottomSheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );

  /// Used For Top Sheet
  static BorderRadius defaultTopSheetRadius = const BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );

  // Used for animations
  static Duration duration = const Duration(milliseconds: 300);
}

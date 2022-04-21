import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/onboarding/data/source.dart';

class CoreController extends GetxController {
  /// Onboarding Screeen
  bool get isOnboardingDone => OnboardingRepository.isIntroDone();

  /// AD Controller
  bool isAdOn = true;
  toggleAds(bool v) {
    isAdOn = v;
    update();
  }

  bool isDependencyLoading = true;

  /// When App Starts
  @override
  void onInit() async {
    super.onInit();
    // await NativeFunctions.init();
    isDependencyLoading = false;

    update();
  }

  /// Theme
  ThemeMode currentThemeMode = ThemeMode.light;
  bool get isDarkModeOn => currentThemeMode == ThemeMode.dark;
}

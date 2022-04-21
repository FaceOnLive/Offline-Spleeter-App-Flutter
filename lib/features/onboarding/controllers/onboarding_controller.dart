import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

import '../../../core/constants/app_defaults.dart';
import '../../../core/routes/app_route.dart';
import '../../home/views/pages/home_page.dart';
import '../data/models/onboard.dart';
import '../data/source.dart';

class OnboardingController extends GetxController {
  /// Get All Onboarding Pages
  List<OnboardingModel> get allPages => OnboardingRepository.allPages;

  /// Pageview Controller
  late PageController pageController;

  /// Current Intro Page
  int currentIndex = 0;

  /// On Page Update
  void onPageSwipe(int index) {
    currentIndex = index;
    update();
  }

  // On Done or Skip
  Future<void> introIsDone(BuildContext context) async {
    /// Save intro has beeen done
    int totalPages = allPages.length;
    if (totalPages == currentIndex + 1) {
      OnboardingRepository.saveIntroDoneLocally();
      AppRoute(context).pushTo(const HomePage());
      Get.delete<OnboardingController>();
    } else {
      pageController.animateToPage(
        currentIndex + 1,
        duration: AppDefaults.duration,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}

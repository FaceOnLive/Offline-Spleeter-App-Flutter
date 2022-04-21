import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../features/home/views/pages/home_page.dart';
import '../../../../features/onboarding/views/pages/onboarding_page.dart';
import '../../controllers/core_controller.dart';

class AppRootView extends StatelessWidget {
  const AppRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      init: CoreController(),
      autoRemove: false,
      builder: (controller) {
        if (controller.isOnboardingDone) {
          return const HomePage();
        } else {
          return const OnboardingPage();
        }
      },
    );
  }
}

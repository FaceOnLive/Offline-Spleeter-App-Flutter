import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../core/constants/app_defaults.dart';
import '../../../../core/constants/app_size_boxes.dart';
import '../../../../core/theme/text_theme.dart';
import '../../controllers/onboarding_controller.dart';
import '../../data/models/onboard.dart';
import '../components/current_page_dots.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OnboardingController>(
          init: OnboardingController(),
          builder: (controller) {
            return Column(
              children: [
                // Skip Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Skip'),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    itemCount: controller.allPages.length,
                    onPageChanged: controller.onPageSwipe,
                    controller: controller.pageController,
                    itemBuilder: (context, index) {
                      return OnboardingViewModel(
                        onboardingModel: controller.allPages[index],
                      );
                    },
                  ),
                ),

                /// Active Dots
                CurrentPageDots(
                  currentIndex: controller.currentIndex,
                  totalPages: controller.allPages.length,
                ),

                /// Action Buttons
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: ElevatedButton(
                      child: const Icon(Icons.arrow_forward_ios_rounded),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        controller.introIsDone(context);
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class OnboardingViewModel extends StatelessWidget {
  const OnboardingViewModel({
    Key? key,
    required this.onboardingModel,
  }) : super(key: key);

  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            onboardingModel.imageLink,
            width: MediaQuery.of(context).size.width * 0.6,
            fit: BoxFit.cover,
          ),
          AppUiBox.h16,
          Text(
            onboardingModel.title,
            style: AppText(context).headline6,
          ),
          AppUiBox.h16,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              onboardingModel.description,
              style: AppText(context).body1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

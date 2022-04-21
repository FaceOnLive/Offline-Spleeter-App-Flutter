import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../core/app/controllers/core_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_defaults.dart';
import '../../../../core/constants/app_size_boxes.dart';
import '../../../../core/theme/text_theme.dart';
import '../../../settings/views/pages/settings.dart';
import '../../controllers/home_page_controller.dart';
import '../components/app_ad_banner.dart';
import '../components/buy_premium_button.dart';
import '../components/header_home.dart';
import '../components/music_choosers.dart';
import 'recent_files_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const SettingsPage()),
            icon: const Icon(
              FeatherIcons.settings,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomePageController>(
          init: HomePageController(),
          autoRemove: false,
          builder: (controller) {
            return Column(
              children: const [
                // Main Column
                UpperSection(),

                BuyPremiumButton(),

                RecentFilesList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class UpperSection extends GetView<HomePageController> {
  const UpperSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppDefaults.defaultTopSheetRadius,
      ),
      child: Column(
        children: [
          const HeaderLogo(),
          AppUiBox.h16,
          const Divider(height: AppDefaults.margin),
          const LoadingSDK(),
          AppUiBox.h16,
          // Choose Music
          AudioPickerTile(
            onLocalButtonPressed: () => controller.pickLocalFiles(context),
            onDemoButtonPressed: () {},
          ),
          AppUiBox.h16,
          const AppAdWidget(),
        ],
      ),
    );
  }
}

class LoadingSDK extends StatelessWidget {
  const LoadingSDK({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      builder: (controller) {
        if (controller.isDependencyLoading) {
          return Column(
            children: [
              Text(
                'Loading SDK',
                style: AppText(context).body1.copyWith(
                      color: Colors.white,
                    ),
              ),
              AppUiBox.h10,
              const LinearProgressIndicator(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

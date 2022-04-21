import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../core/app/controllers/core_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';
import '../components/header_column.dart';
import '../components/settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HeaderColumn(),
              AppUiBox.h16,
              Divider(),
              AllSettings(),
              CopyrightInfo()
            ],
          ),
        ),
      ),
    );
  }
}

class CopyrightInfo extends StatelessWidget {
  const CopyrightInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.margin),
      child: Text(
        'All rights are reserved by Turing Alan.\nCopyright 2020 Turing Alan.',
        textAlign: TextAlign.center,
        style: AppText(context).caption,
      ),
    );
  }
}

class AllSettings extends StatelessWidget {
  const AllSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      builder: (controller) {
        return Column(
          children: [
            SettingListTile(
              leading: const Icon(FeatherIcons.moon, color: AppColors.primary),
              title: const Text('Dark Mode'),
              trailing: Switch.adaptive(
                  value: controller.isDarkModeOn, onChanged: (v) {}),
            ),
            SettingListTile(
              leading: const Icon(FeatherIcons.box, color: AppColors.primary),
              title: const Text('Ads'),
              trailing: Switch.adaptive(
                value: controller.isAdOn,
                onChanged: controller.toggleAds,
              ),
            ),
            SettingListTile(
              leading: const Icon(FeatherIcons.gift, color: AppColors.primary),
              title: const Text('Buy Premium'),
              onTap: () {},
            ),
            SettingListTile(
              leading: const Icon(FeatherIcons.info, color: AppColors.primary),
              title: const Text('About'),
              onTap: () {},
            ),
            SettingListTile(
              leading: const Icon(FeatherIcons.send, color: AppColors.primary),
              title: const Text('Patreon'),
              onTap: () {},
            ),
            SettingListTile(
              leading: const Icon(FeatherIcons.phone, color: AppColors.primary),
              title: const Text('Contact Us'),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

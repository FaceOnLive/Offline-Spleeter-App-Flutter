import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/text_theme.dart';
import '../components/app_ad_banner.dart';
import '../components/recent_files_tile.dart';

class RecentFilesList extends StatelessWidget {
  const RecentFilesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Files',
            style: AppText(context).body1.copyWith(fontWeight: FontWeight.bold),
          ),
          AppUiBox.h16,
          const RecentFilesTile(fileName: 'Chatni.wav', fileLocation: ''),
          const RecentFilesTile(
              fileName: 'recording 005.wav', fileLocation: ''),
          const RecentFilesTile(
              fileName: 'recording 005.wav', fileLocation: ''),
          const AppAdWidget(),
          const RecentFilesTile(
              fileName: 'Avenger Theme song.wav', fileLocation: ''),
        ],
      ),
    );
  }
}

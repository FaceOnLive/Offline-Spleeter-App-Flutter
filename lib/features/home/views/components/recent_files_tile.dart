import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../../../core/constants/constants.dart';

class RecentFilesTile extends StatelessWidget {
  const RecentFilesTile({
    Key? key,
    required this.fileName,
    required this.fileLocation,
  }) : super(key: key);

  final String fileName;
  final String fileLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      child: ListTile(
        leading: const Icon(
          FeatherIcons.music,
          color: AppColors.primary,
        ),
        title: Text(fileName),
      ),
    );
  }
}

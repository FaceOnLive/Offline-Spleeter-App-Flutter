import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../core/constants/constants.dart';

class TapToRecordButton extends StatelessWidget {
  const TapToRecordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {},
          label: const Text('Tap To Record'),
          icon: const Icon(FeatherIcons.mic),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/text_theme.dart';

import '../../../constants/constants.dart';

class SuccessDialog extends StatelessWidget {
  final String message, title;
  const SuccessDialog({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: AppText(context).headline6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
          ),
          const Divider(
            // color: Color,
            thickness: 0.3,
          ),
          Container(
            padding: const EdgeInsets.all(
              AppDefaults.padding,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_box_rounded,
                  color: Colors.green,
                  size: Get.width * 0.2,
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

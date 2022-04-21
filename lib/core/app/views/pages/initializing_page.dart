import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_size_boxes.dart';

class InitializingPage extends StatelessWidget {
  const InitializingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  Image.asset(
                    AppImages.logo,
                  ),
                  const Text('Loading Splitter SDK'),
                  AppUiBox.h10,
                  const LinearProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

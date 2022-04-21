import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:worker_manager/worker_manager.dart';

import 'core/app/controllers/core_controller.dart';
import 'core/app/views/pages/root_view.dart';
import 'core/native_bridge/functions.dart';
import 'core/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await MobileAds.instance.initialize();
  await NativeFunctions.init();
  runApp(const MyApp());
  await Executor().warmUp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Song Splitter',
      theme: AppTheme.lightTheme,
      themeMode: CoreController().currentThemeMode,
      home: const AppRootView(),
      defaultTransition: Transition.cupertino,
      onDispose: NativeFunctions.disposeAudio,
    );
  }
}

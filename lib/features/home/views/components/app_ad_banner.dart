import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/app/controllers/core_controller.dart';

class AppAdWidget extends StatefulWidget {
  const AppAdWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AppAdWidget> createState() => _AppAdWidgetState();
}

class _AppAdWidgetState extends State<AppAdWidget> {
  final bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    request: const AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdClosed: (ad) => ad.dispose(),
      onAdFailedToLoad: (ad, e) => ad.dispose(),
      onAdLoaded: (ad) {},
    ),
  );

  /// if we should load ad
  shouldLoadAd() async {
    bool _shouldLoadAd = Get.find<CoreController>().isAdOn;
    if (_shouldLoadAd) {
      await bannerAd.load();
    } else {}
  }

  @override
  void initState() {
    super.initState();
    shouldLoadAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      builder: (controller) {
        if (controller.isAdOn) {
          return SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: AdWidget(
              ad: bannerAd,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

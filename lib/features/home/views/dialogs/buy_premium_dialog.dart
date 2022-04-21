import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../../../core/routes/app_route.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_defaults.dart';
import '../../../../core/constants/app_size_boxes.dart';
import '../../../../core/theme/text_theme.dart';
import '../components/package_selector.dart';

class BuyPremiumDialog extends StatelessWidget {
  const BuyPremiumDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const PackagesRow(),

            // Features
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppUiBox.h10,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('- Export Unlimited Songs'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('- No Ads'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('- Multiple Audio Format'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('- Cancel Anytime'),
                ),
              ],
            ),
            AppUiBox.h16,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Buy Now'),
              ),
            ),
            AppUiBox.h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Privacy Policy'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Terms Of Use'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PackagesRow extends StatelessWidget {
  const PackagesRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PackageSelector(
            amount: '\$4',
            duration: 'Month',
            bottomText: 'Billed Monthly',
            onTap: () {},
            isSelected: false,
          ),
        ),
        AppUiBox.w16,
        Expanded(
          child: PackageSelector(
            amount: '\$29',
            duration: 'Yearly',
            topText: 'Most Popular',
            bottomText: 'Save 18%',
            onTap: () {},
            isSelected: true,
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDefaults.margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Premium',
            style: AppText(context).body1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          IconButton(
            onPressed: () => AppRoute(context).pop(),
            icon: const Icon(FeatherIcons.xCircle),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

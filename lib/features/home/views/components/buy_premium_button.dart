import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../dialogs/buy_premium_dialog.dart';

class BuyPremiumButton extends StatelessWidget {
  const BuyPremiumButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.margin),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => const BuyPremiumDialog(),
            );
          },
          child: const Text('Buy Premium'),
        ),
      ),
    );
  }
}

import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseRepository {
  static const apiKey = '';

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(apiKey);
  }

  Future<List<Offering>> fetchOffering() async {
    final offerings = await Purchases.getOfferings();
    final _currentOffering = offerings.current;
    return _currentOffering == null ? [] : [_currentOffering];
  }
}

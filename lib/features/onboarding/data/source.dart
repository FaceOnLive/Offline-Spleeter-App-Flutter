import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_images.dart';
import 'models/onboard.dart';

class OnboardingRepository {
  static List<OnboardingModel> allPages = [
    OnboardingModel(
      title: 'Modify music to your needs',
      description: 'Without damaging the experience split out the best',
      imageLink: AppImages.onboarding1,
    ),
    OnboardingModel(
      title: 'Modify music to your needs',
      description: 'Without damaging the experience split out the best',
      imageLink: AppImages.onboarding2,
    ),
    OnboardingModel(
      title: 'Modify music to your needs',
      description: 'Without damaging the experience split out the best',
      imageLink: AppImages.onboarding3,
    )
  ];

  /// Save Intro has been Done Locally
  static const String _keyName = 'onboardingInfo';

  static Future<void> saveIntroDoneLocally() async {
    final box = GetStorage();
    box.write(_keyName, true);
  }

  /// If the intro has been done
  static bool isIntroDone() {
    bool _isIntroDone = false;
    final box = GetStorage();
    _isIntroDone = box.read(_keyName) ?? false;
    return _isIntroDone;
  }
}

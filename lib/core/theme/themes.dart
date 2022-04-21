import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import '../utils/app_ui_helper.dart';

class AppTheme {
  final BuildContext context;
  AppTheme(this.context);

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      displayColor: AppColors.darkPrimary,
      bodyColor: AppColors.darkPrimary,
    ),
    scaffoldBackgroundColor: AppColors.lightThemeScaffold,
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(
        color: AppColors.darkPrimary,
      ),
      titleTextStyle: Get.textTheme.bodyText1!.copyWith(
        color: AppColors.darkPrimary,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      backgroundColor: AppColors.lightThemeScaffold,
      iconTheme: const IconThemeData(color: AppColors.darkPrimary),
      toolbarTextStyle: Get.textTheme.bodyText1!,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: AppDefaults.borderRadius,
        borderSide: const BorderSide(
          color: AppColors.lineShape,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppDefaults.borderRadius,
        borderSide: const BorderSide(
          color: AppColors.lineShape,
        ),
      ),
      fillColor: Colors.white,
      filled: true,
      prefixIconColor: AppColors.textBody,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(AppDefaults.padding),
          shadowColor: AppColors.primary.withOpacity(0.25),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
          textStyle: Get.textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
          )),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(AppDefaults.padding),
        shape: RoundedRectangleBorder(
          borderRadius: AppDefaults.borderRadius,
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppUiHelper.generateMaterialColor(AppColors.primary),
    ).copyWith(secondary: AppColors.secondary),
  );
}

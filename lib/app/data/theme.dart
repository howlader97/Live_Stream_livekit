import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,

    textTheme: TextTheme(bodyLarge: TextStyle(color: AppColors.whiteLight)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      selectedLabelStyle: AppTextStyles.medium12,
      unselectedLabelStyle: AppTextStyles.medium12,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles.bold16,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteLight,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.whiteLight,
          width: 1,),
        textStyle: AppTextStyles.bold16,
        backgroundColor: AppColors.outlineButtonColor,
        foregroundColor: AppColors.whiteLight,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.whiteLight),
      labelStyle: TextStyle(color: AppColors.whiteLight),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.whiteLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.whiteLight),
      ),
    ),
  );
}

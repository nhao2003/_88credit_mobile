import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      //fontFamily: 'Muli',
      appBarTheme: appBarTheme(),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
      useMaterial3: true,
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.black),
      titleTextStyle: AppTextStyles.semiBold18.colorEx(AppColors.green),
    );
  }
}

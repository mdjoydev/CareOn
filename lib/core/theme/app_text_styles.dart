import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const String _fontFamily = 'Roboto';

  static TextTheme get textTheme => TextTheme(
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      );
}

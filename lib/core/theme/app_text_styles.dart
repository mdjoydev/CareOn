import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const String _fontFamily = 'Roboto';

  /// Scaled font size that respects accessibility + device size.
  static double _scaleFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.sizeOf(context).width;
    final scale = (width / 375).clamp(0.8, 1.2);
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    return (baseSize * scale).clamp(baseSize * 0.8, baseSize * 1.2) * textScale;
  }

  static TextTheme getTextTheme(BuildContext context) => TextTheme(
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 20),
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 18),
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 18),
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 16),
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 14),
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 13),
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 14),
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _scaleFontSize(context, 12),
          color: AppColors.textSecondary,
        ),
      );
}

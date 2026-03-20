import 'package:flutter/material.dart';

/// Responsive utilities to prevent overflow on any device size.
class Responsive {
  const Responsive._();

  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  /// Returns a scale factor for the current screen width.
  static double widthScale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / _baseWidth).clamp(0.8, 1.2);
  }

  /// Returns a scale factor for the current screen height.
  static double heightScale(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return (height / _baseHeight).clamp(0.8, 1.2);
  }

  /// Scales a dimension based on screen width.
  static double scale(BuildContext context, double base) {
    return base * widthScale(context);
  }

  /// Scales a dimension based on screen height.
  static double hScale(BuildContext context, double base) {
    return base * heightScale(context);
  }

  /// Returns adaptive padding.
  static double scalePadding(BuildContext context, double base) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return base * 0.75;
    if (width < 400) return base * 0.9;
    return base;
  }

  /// Returns adaptive spacing.
  static double scaleSpacing(BuildContext context, double base) {
    final height = MediaQuery.sizeOf(context).height;
    if (height < 600) return base * 0.7;
    if (height < 700) return base * 0.85;
    return base;
  }

  /// Scaled font size that respects accessibility + device size.
  static double scaleFontSize(BuildContext context, double baseSize) {
    final scale = widthScale(context);
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    return (baseSize * scale).clamp(baseSize * 0.8, baseSize * 1.2) * textScale;
  }
}

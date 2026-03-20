import 'package:flutter/material.dart';

import '../core/constants/spacing.dart';
import '../core/theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final baseColor = backgroundColor ?? AppColors.nursingBg;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

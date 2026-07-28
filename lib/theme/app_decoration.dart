import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppDecoration {
  AppDecoration._();

  // ==========================
  // Floating Navigation
  // ==========================

  static BoxDecoration navbar = BoxDecoration(
    color: AppColors.navbarBackground,
    borderRadius: BorderRadius.circular(
      AppSizes.radiusXL,
    ),
    border: Border.all(
      color: AppColors.border,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 35,
        spreadRadius: 2,
        offset: const Offset(0, 14),
      ),
    ],
  );

  // ==========================
  // Cards
  // ==========================

  static BoxDecoration card = BoxDecoration(
    color: AppColors.card,
    borderRadius: BorderRadius.circular(
      AppSizes.radiusLG,
    ),
  );

  // ==========================
  // Search
  // ==========================

  static BoxDecoration searchField = BoxDecoration(
    color: AppColors.searchBackground,
    borderRadius: BorderRadius.circular(
      AppSizes.radiusFull,
    ),
    border: Border.all(
      color: AppColors.searchBorder,
    ),
  );

  // ==========================
  // Indicator
  // ==========================

  static BoxDecoration indicator = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(
      AppSizes.radiusFull,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryGlow,
        blurRadius: 18,
        spreadRadius: 2,
      ),
    ],
  );
}
import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  // ==========================
  // Brand & Logo
  // ==========================
  static TextStyle get logo => TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
        letterSpacing: -0.8,
      );

  // ==========================
  // Headers & Titles
  // ==========================
  static TextStyle get titleLarge => TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      );

  static TextStyle get title => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      );

  static TextStyle get titleMedium => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      );

  static TextStyle get subtitle => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  // ==========================
  // Body
  // ==========================
  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  // ==========================
  // Cards & Movies
  // ==========================
  static TextStyle get movieTitle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
        height: 1.2,
      );

  static TextStyle get movieInfo => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get rating => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      );

  // ==========================
  // Inputs & Search
  // ==========================
  static TextStyle get searchInput => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
      );

  static TextStyle get searchHint => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
      );

  // ==========================
  // Buttons & Badges
  // ==========================
  static TextStyle get button => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      );

  static TextStyle get badge => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  // ==========================
  // Bottom Navigation
  // ==========================
  static TextStyle get navigation => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      );

  static TextStyle get navigationInactive => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );
}


// lib/core/theme/app_text_styles.dart
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Display & Headings
  static TextStyle get displayLarge => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppTheme.primaryColor,
    fontFamily: 'DM Sans',
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppTheme.primaryColor,
    fontFamily: 'Inter',
    height: 1.2,
    letterSpacing: 3,
  );

  static TextStyle get displaySmall => TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    fontFamily: 'DM Sans',
    color: AppTheme.primaryColor,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppTheme.primaryColor,
    fontFamily: 'Inter',
  );

  static TextStyle get headlineSmall => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.7,
    color: AppTheme.primaryColor,
    fontFamily: 'DM Sans',
  );

  // Titles
  static TextStyle get titleLarge => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppTheme.primaryColor,
    fontFamily: 'DM Sans',
  );

  static TextStyle get titleMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppTheme.secondaryColor,
    fontFamily: 'DM Sans',
  );

  // Body
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppTheme.primaryColor,
    fontFamily: 'DM Sans',
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppTheme.secondaryColor,
    height: 1.5,
    fontFamily: 'DM Sans',
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    color: AppTheme.secondaryColor,
    fontFamily: 'DM Sans',
  );

  // Labels
  static TextStyle get labelMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppTheme.primaryColor,
    fontFamily: 'DM Sans',
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppTheme.primaryColor,
    fontFamily: 'DM Sans',
  );

  // Button Style
  static TextStyle get button => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    fontFamily: 'DM Sans',
  );
}

import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    fontFamily: 'DM Sans',
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.backgroundColor,
      error: Colors.red,
    ),

    // ── AppBar ───────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),

    // ── ListTile (for GlobalListItem) ─────────
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.primaryColor,
      textColor: AppColors.primaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
    ),

    // ── Text ─────────────────────────────────
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
        fontFamily: 'DM Sans',
      ),
      displayMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
        fontFamily: 'inter',
        letterSpacing: 3,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w500,
        fontFamily: 'DM Sans',
        color: AppColors.primaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: AppColors.primaryColor,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
        fontFamily: 'DM Sans',
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryColor,
        fontFamily: 'DM Sans',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryColor,
        fontFamily: 'DM Sans',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.secondaryColor,
        height: 1.5,
        fontFamily: 'DM Sans',
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color: AppColors.secondaryColor,
        fontFamily: 'DM Sans',
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
        fontFamily: 'DM Sans',
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
        fontFamily: 'DM Sans',
      ),
    ),

    // ── Input Fields ─────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColors.secondaryColor,
        fontFamily: 'DM Sans',
        fontSize: 14,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColors.primaryColor,
        fontFamily: 'DM Sans',
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
    ),

    // ── Elevated Button ───────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.backgroundColor,
        elevation: 0,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        textStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // ── Text Button ───────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),

    // ── Checkbox ──────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return Color(0xffF5F8FA);
      }),
      side: const BorderSide(color: AppColors.borderColor, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── Divider ───────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.borderColor,
      thickness: 1,
      space: 1,
    ),

    // ── Drawer ────────────────────────────────
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.backgroundColor,
    ),

    // ── SnackBar ──────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primaryColor,
      contentTextStyle: const TextStyle(
        color: AppColors.backgroundColor,
        fontFamily: 'DM Sans',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

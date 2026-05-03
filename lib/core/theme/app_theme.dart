import 'package:e_commerce_project/core/theme/custom_border.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF142535);
  static const Color secondaryColor = Color(0xFF4A5F73);
  static const Color borderColor = Color(0xFFDBE9F5);
  static const Color cardBackgroundColor = Color(0XFFF6F8FB);
  static const Color secondaryBackgroundColor = Color(0xFFF7F9FA);
  AppTheme._();

  static ThemeData get light => ThemeData(
    fontFamily: 'DM Sans',
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundColor,
      error: Colors.red,
    ),

    // ── AppBar ───────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      iconTheme: IconThemeData(color: primaryColor),
    ),

    // ── ListTile (for GlobalListItem) ─────────
    listTileTheme: const ListTileThemeData(
      iconColor: primaryColor,
      textColor: primaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
    ),

    // // ── Text ─────────────────────────────────
    // textTheme: const TextTheme(
    //   displayLarge: TextStyle(
    //     fontSize: 32,
    //     fontWeight: FontWeight.bold,
    //     color: primaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   displayMedium: TextStyle(
    //     fontSize: 18,
    //     fontWeight: FontWeight.w500,
    //     color: primaryColor,
    //     fontFamily: 'inter',
    //     height: 1.2,
    //     letterSpacing: 3,
    //   ),
    //   displaySmall: TextStyle(
    //     fontSize: 14,
    //     height: 1.5,
    //     fontWeight: FontWeight.w500,
    //     fontFamily: 'DM Sans',
    //     color: primaryColor,
    //   ),
    //   headlineMedium: TextStyle(
    //     fontSize: 20,
    //     fontWeight: FontWeight.w500,
    //     height: 1.2,
    //     color: primaryColor,
    //     fontFamily: 'Inter',
    //   ),
    //   headlineSmall: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w400,
    //     height: 1.7,
    //     color: primaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   titleLarge: TextStyle(
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //     color: primaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   titleMedium: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w400,
    //     color: secondaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   bodyLarge: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.normal,
    //     color: primaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   bodyMedium: TextStyle(
    //     fontSize: 14,
    //     fontWeight: FontWeight.normal,
    //     color: secondaryColor,
    //     height: 1.5,
    //     fontFamily: 'DM Sans',
    //   ),
    //   bodySmall: TextStyle(
    //     fontSize: 11,
    //     fontWeight: FontWeight.normal,
    //     color: secondaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   labelMedium: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w600,
    //     color: primaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    //   labelSmall: TextStyle(
    //     fontSize: 12,
    //     fontWeight: FontWeight.bold,
    //     color: primaryColor,
    //     fontFamily: 'DM Sans',
    //   ),
    // ),

    // ── Input Fields ─────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: secondaryColor,
        fontFamily: 'DM Sans',
        fontSize: 14,
      ),
      floatingLabelStyle: const TextStyle(
        color: primaryColor,
        fontFamily: 'DM Sans',
        fontSize: 14,
      ),
      enabledBorder: CustomBorder(color: AppTheme.borderColor),
      focusedBorder: CustomBorder(color: AppTheme.borderColor),
      errorBorder: CustomBorder(color: AppTheme.borderColor),
      focusedErrorBorder: CustomBorder(color: AppTheme.borderColor),
      disabledBorder: CustomBorder(color: AppTheme.borderColor),
    ),

    // ── Elevated Button ───────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: backgroundColor,
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
        foregroundColor: primaryColor,
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
          return primaryColor;
        }
        return Color(0xffF5F8FA);
      }),
      side: const BorderSide(color: borderColor, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── Divider ───────────────────────────────
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 1,
      space: 1,
    ),

    // ── Drawer ────────────────────────────────
    drawerTheme: const DrawerThemeData(backgroundColor: backgroundColor),

    // ── SnackBar ──────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryColor,
      contentTextStyle: const TextStyle(
        color: backgroundColor,
        fontFamily: 'DM Sans',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// // lib/core/theme/app_theme.dart
// import 'package:e_commerce_project/core/theme/app_text_styles.dart';
// import 'package:e_commerce_project/core/theme/custom_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AppTheme {
//   static const Color backgroundColor = Color(0xFFFFFFFF);
//   static const Color primaryColor = Color(0xFF142535);
//   static const Color secondaryColor = Color(0xFF4A5F73);
//   static const Color borderColor = Color(0xFFDBE9F5);
//   static const Color cardBackgroundColor = Color(0xFFF6F8FB);
//   static const Color secondaryBackgroundColor = Color(0xFFF7F9FA);

//   AppTheme._();

//   static ThemeData get light => ThemeData(
//     fontFamily: 'DM Sans',
//     scaffoldBackgroundColor: backgroundColor,
//     primaryColor: primaryColor,
//     colorScheme: ColorScheme.light(
//       primary: primaryColor,
//       secondary: secondaryColor,
//       surface: backgroundColor,
//       error: Colors.red,
//     ),

//     // ── AppBar ───────────────────────────────
//     appBarTheme: AppBarTheme(
//       backgroundColor: backgroundColor,
//       foregroundColor: primaryColor,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle: AppTextStyles.headlineSmall.copyWith(fontSize: 18),
//       iconTheme: const IconThemeData(color: primaryColor),
//     ),

//     // ── ListTile ─────────────────────────────
//     listTileTheme: const ListTileThemeData(
//       iconColor: primaryColor,
//       textColor: primaryColor,
//       contentPadding: EdgeInsets.symmetric(horizontal: 20),
//     ),

//     // ── Text Theme ───────────────────────────
//     textTheme: TextTheme(
//       displayLarge: AppTextStyles.displayLarge,
//       displayMedium: AppTextStyles.displayMedium,
//       displaySmall: AppTextStyles.displaySmall,
//       headlineMedium: AppTextStyles.headlineMedium,
//       headlineSmall: AppTextStyles.headlineSmall,
//       titleLarge: AppTextStyles.titleLarge,
//       titleMedium: AppTextStyles.titleMedium,
//       bodyLarge: AppTextStyles.bodyLarge,
//       bodyMedium: AppTextStyles.bodyMedium,
//       bodySmall: AppTextStyles.bodySmall,
//       labelMedium: AppTextStyles.labelMedium,
//       labelSmall: AppTextStyles.labelSmall,
//     ),

//     // ── Input Fields ─────────────────────────
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: TextStyle(
//         color: secondaryColor,
//         fontFamily: 'DM Sans',
//         fontSize: 14,
//       ),
//       floatingLabelStyle: TextStyle(
//         color: primaryColor,
//         fontFamily: 'DM Sans',
//         fontSize: 14,
//       ),
//       enabledBorder: CustomBorder(color: borderColor),
//       focusedBorder: CustomBorder(color: borderColor),
//       errorBorder: CustomBorder(color: borderColor),
//       focusedErrorBorder: CustomBorder(color: borderColor),
//       disabledBorder: CustomBorder(color: borderColor),
//     ),

//     // ── Elevated Button ───────────────────────
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.transparent,
//         foregroundColor: backgroundColor,
//         elevation: 0,
//         minimumSize: const Size(double.infinity, 52),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         textStyle: AppTextStyles.button,
//       ),
//     ),

//     // ── Text Button ───────────────────────────
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: primaryColor,
//         textStyle: TextStyle(
//           fontFamily: 'DM Sans',
//           fontSize: 16,
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//     ),

//     // ── Checkbox ──────────────────────────────
//     checkboxTheme: CheckboxThemeData(
//       fillColor: WidgetStateProperty.resolveWith((states) {
//         if (states.contains(WidgetState.selected)) return primaryColor;
//         return const Color(0xffF5F8FA);
//       }),
//       side: const BorderSide(color: borderColor, width: 1.5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//     ),

//     // ── Divider ───────────────────────────────
//     dividerTheme: const DividerThemeData(
//       color: borderColor,
//       thickness: 1,
//       space: 1,
//     ),

//     drawerTheme: const DrawerThemeData(backgroundColor: backgroundColor),

//     snackBarTheme: SnackBarThemeData(
//       backgroundColor: primaryColor,
//       contentTextStyle: TextStyle(
//         color: backgroundColor,
//         fontFamily: 'DM Sans',
//         fontSize: 14,
//       ),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       behavior: SnackBarBehavior.floating,
//     ),
//   );
// }

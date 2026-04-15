import 'package:e_commerce_project/app_page.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/auth/data/services/auth_service.dart';
import 'package:e_commerce_project/features/auth/presentation/widgets/signin_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.init();
  runApp(const EcoummerceApp());
}

class EcoummerceApp extends StatelessWidget {
  const EcoummerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AppPage(),
    );
  }
}

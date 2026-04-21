import 'package:e_commerce_project/core/providers/cart_provider.dart';
import 'package:e_commerce_project/core/providers/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_router.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: const EcoummerceApp(),
    ),
  );
}

class EcoummerceApp extends StatelessWidget {
  const EcoummerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.screens,
      onGenerateRoute: AppRouter.generateRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.textScalerOf(context).scale(1).clamp(0.85, 1),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

import 'dart:io';
import 'package:e_commerce_project/features/auth/provider/auth_provider.dart';
import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/features/screens/home/provider/home_provider.dart';
import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_router.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:path/path.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection_container.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  final appPreferences = AppPreferences(prefs);
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        Provider<AppPreferences>(create: (_) => appPreferences),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        // ChangeNotifierProvider(
        //   create: (context) => di.sl<RelatedProductsProvider>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.sl<ProductDetailProvider>(),
        // ),
        ChangeNotifierProvider(
          create: (context) => di.sl<HomeProvider>()..loadDashboard(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.sl<ProductsProvider>()..loadProducts(),
        ),
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
      initialRoute: AppRoutes.splash,
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

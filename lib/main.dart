import 'dart:io';
import 'package:e_commerce_project/core/helper/db_helpers.dart';
import 'package:e_commerce_project/core/providers/navigation_provider.dart';
import 'package:e_commerce_project/features/auth/provider/auth_provider.dart';
import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:e_commerce_project/features/relatedproducts/data/repositories/related_product_repository.dart';
import 'package:e_commerce_project/features/relatedproducts/provider/related_product_provider.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/features/screens/home/provider/home_provider.dart';
import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_router.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ),
  );

  // Load home and products data in parallel
  final homeProvider = di.sl<HomeProvider>();
  final productsProvider = di.sl<ProductsProvider>();
  final relatedProvider = RelatedProductsProvider(
    repository: di.sl<RelatedProductsRepository>(),
  );
  Future.wait([homeProvider.loadDashboard(), productsProvider.loadProducts()]);
  await di.sl<DbHelper>().db; // Force initialization + upgrade
  await di.sl<DbHelper>().db;
  runApp(
    MultiProvider(
      providers: [
        Provider<AppPreferences>(create: (_) => appPreferences),
        ChangeNotifierProvider(
          create: (context) => CartProvider(dbHelper: di.sl<DbHelper>()),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(dbHelper: di.sl<DbHelper>()),
        ),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => relatedProvider),
        ChangeNotifierProvider(create: (context) => homeProvider),
        ChangeNotifierProvider(create: (context) => productsProvider),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: const EcoummerceApp(),
    ),
  );
}

class EcoummerceApp extends StatelessWidget {
  const EcoummerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light.copyWith(
          appBarTheme: AppTheme.light.appBarTheme.copyWith(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          ),
        ),

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
      ),
    );
  }
}

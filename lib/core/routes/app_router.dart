import 'package:e_commerce_project/core/widgets/category.dart';
import 'package:e_commerce_project/features/product/presentation/description_screen.dart';
import 'package:e_commerce_project/features/product/presentation/product_detail_page.dart';
import 'package:e_commerce_project/features/screens/screens.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/features/auth/presentation/widgets/signin_page.dart';
import 'package:e_commerce_project/features/auth/presentation/widgets/signup_page.dart';
import 'package:e_commerce_project/features/onboarding/presentation/onboarding_page.dart';
import 'package:e_commerce_project/features/splash/presentation/splash_page.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _route(const SplashPage());

      case AppRoutes.onboarding:
        return _route(const OnboardingPage());

      case AppRoutes.signin:
        return _route(const SigninPage());

      case AppRoutes.signup:
        return _route(const SignupPage());

      case AppRoutes.screens:
        return _route(const Screens());

      case AppRoutes.category:
        final args = settings.arguments as Map<String, dynamic>;
        return _route(
          Category(
            title: args['title'] as String?,
            products: args['products'] as List<ProductsModel>?,
          ),
        );
      case AppRoutes.productDetail:
        final args = settings.arguments as ProductsModel;
        return _route(ProductDetailPage(product: args));

      case AppRoutes.description:
        final args = settings.arguments as ProductsModel;
        return _route(DescriptionScreen(product: args));
      default:
        return _route(const Screens());
    }
  }

  static MaterialPageRoute _route(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}

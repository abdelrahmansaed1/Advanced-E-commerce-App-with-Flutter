import 'package:e_commerce_project/core/di/injection_container.dart' as di;
import 'package:e_commerce_project/features/category/presentation/category.dart';
import 'package:e_commerce_project/features/product/presentation/description_screen.dart';
import 'package:e_commerce_project/features/product/presentation/product_detail_page.dart';
import 'package:e_commerce_project/features/product/provider/product_detail_provider.dart';
import 'package:e_commerce_project/features/screens/profile/presentation/widgets/edit_profile.dart';
import 'package:e_commerce_project/features/screens/screens.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/features/auth/presentation/signin_page.dart';
import 'package:e_commerce_project/features/auth/presentation/signup_page.dart';
import 'package:e_commerce_project/features/onboarding/presentation/onboarding_page.dart';
import 'package:e_commerce_project/features/splash/presentation/splash_page.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/product/data/repositories/product_detail_repository.dart';

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
        return _route(Category(title: args['title'] as String?));

      case AppRoutes.description:
        final args = settings.arguments as ProductModel;
        return _route(DescriptionScreen(product: args));
      case AppRoutes.editProfile:
        return _route(const EditProfile());
      case AppRoutes.productDetail:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ProductDetailProvider(
              repository: di.sl<ProductDetailRepository>(),
            )..loadProduct(productId: productId),
            child: ProductDetailPage(productId: productId),
          ),
        );
      default:
        return _route(const Screens());
    }
  }

  static MaterialPageRoute _route(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}

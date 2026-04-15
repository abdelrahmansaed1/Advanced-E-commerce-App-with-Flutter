import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  AppImages._();

  // images
  static const String personal = 'assets/images/personal.png';

  // svgs
  static const String logo = 'assets/images/logo.svg';
  static const String burger = 'assets/images/Burger.svg';
  static const String shoppingCart = 'assets/images/shopping-cart.svg';
  static const String bell = 'assets/images/bell.svg';
  static const String helpCircle = 'assets/images/help-circle.svg';
  static const String active = 'assets/images/active.svg';
  static const String user = 'assets/images/user.svg';
  static const String bottomShoppingCart =
      'assets/images/bottom-shopping-cart.svg';
  static const String search = 'assets/images/search.svg';
  static const String add = 'assets/images/plus.svg';
  static const String home = 'assets/images/home.svg';
  static const String heart = 'assets/images/heart.svg';

  // widgets
  static Widget logoSvg({double? width, double? height}) => SvgPicture.asset(
    logo,
    width: width,
    height: height,
    semanticsLabel: 'Logo',
  );

  static Widget burgerSvg({double? width, double? height}) => SvgPicture.asset(
    burger,
    width: width,
    height: height,
    semanticsLabel: 'Burger',
  );

  static Widget shoppingCartSvg({double? width, double? height}) =>
      SvgPicture.asset(
        shoppingCart,
        width: width,
        height: height,
        semanticsLabel: 'Shopping Cart',
      );

  static Widget bellSvg({double? width, double? height}) => SvgPicture.asset(
    bell,
    width: width,
    height: height,
    semanticsLabel: 'Bell',
  );

  static Widget helpCircleSvg({double? width, double? height}) =>
      SvgPicture.asset(
        helpCircle,
        width: width,
        height: height,
        semanticsLabel: 'Help Circle',
      );

  static Widget activeSvg({double? width, double? height}) => SvgPicture.asset(
    active,
    width: width,
    height: height,
    semanticsLabel: 'Active',
  );
  static Widget homeSvg({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        home,
        width: width,
        height: height,
        semanticsLabel: 'Home',
      );
  static Widget bottomShoppingCartSvg({
    double? width,
    double? height,
    Color? color,
  }) => SvgPicture.asset(
    bottomShoppingCart,
    width: width,
    height: height,
    semanticsLabel: 'Bottom Shopping Cart',
  );
  static Widget heartSvg({
    double? width,
    double? height,
    ColorFilter? colorFilter,
    Color? color,
  }) => SvgPicture.asset(
    heart,
    width: width,
    height: height,
    colorFilter:
        colorFilter ??
        (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
    semanticsLabel: 'Heart',
  );
  static Widget addSvg({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        add,
        width: width,
        height: height,
        semanticsLabel: 'Plus',
      );
  static Widget searchSvg({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        search,
        width: width,
        height: height,
        semanticsLabel: 'Search',
      );
  static Widget userSvg({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        user,
        width: width,
        height: height,
        semanticsLabel: 'User',
      );
}

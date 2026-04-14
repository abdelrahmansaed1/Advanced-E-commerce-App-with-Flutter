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
  static const String active = 'assets/images/active_home_icon.svg';

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
}

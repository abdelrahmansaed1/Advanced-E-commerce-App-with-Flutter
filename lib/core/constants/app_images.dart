import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  AppImages._();

  // images
  static const String personal = 'assets/images/personal.png';

  // svgs
  static const String logo = 'assets/images/ic_logo.svg';
  static const String burger = 'assets/images/ic_burger.svg';
  static const String shoppingCart = 'assets/images/ic_shopping_cart.svg';
  static const String bell = 'assets/images/ic_bell.svg';
  static const String helpCircle = 'assets/images/ic_help-circle.svg';
  static const String active = 'assets/images/ic_active.svg';
  static const String user = 'assets/images/ic_user.svg';
  static const String bottomShoppingCart =
      'assets/images/ic_bottom_shopping_cart.svg';
  static const String search = 'assets/images/ic_search.svg';
  static const String add = 'assets/images/ic_add.svg';
  static const String home = 'assets/images/ic_home.svg';
  static const String heart = 'assets/images/ic_heart.svg';
  static const String heartFilled = 'assets/images/ic_heart_filled.svg';
  static const String filter = 'assets/images/ic_filter.svg';
  static const String trash = 'assets/images/ic_trash.svg';
  static const String camera = 'assets/images/ic_camera.svg';
  static const String logout = 'assets/images/ic_log_out.svg';
  static const String gift = 'assets/images/ic_gift.svg';
  static const String mapPin = 'assets/images/ic_map_pin.svg';
  static const String creditCard = 'assets/images/ic_credit_card.svg';
  static const String server = 'assets/images/ic_server.svg';
  static const String edit = 'assets/images/ic_edit.svg';

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
    Color? color,
    bool isFilled = false,
  }) {
    final String assetPath = isFilled == true
        ? heartFilled // المسار للأيقونة الممتلئة
        : heart; // المسار للأيقونة الفارغة

    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      semanticsLabel: isFilled ? 'Filled Heart' : 'Heart',
    );
  }

  static Widget addSvg({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        add,
        width: width,
        height: height,
        semanticsLabel: 'Plus',
      );
  static Widget searchSvg({
    double? width,
    double? height,
    Color? color,
    ColorFilter? colorFilter,
  }) => SvgPicture.asset(
    search,
    width: width,
    height: height,
    semanticsLabel: 'Search',
    colorFilter:
        colorFilter ??
        (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
  );
  static Widget userSvg({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        user,
        width: width,
        height: height,
        semanticsLabel: 'User',
      );

  static Widget filterSvg({double? width, double? height}) => SvgPicture.asset(
    filter,
    width: width,
    height: height,
    semanticsLabel: 'Filter',
  );
  static Widget trashSvg({double? width, double? height}) => SvgPicture.asset(
    trash,
    width: width,
    height: height,
    semanticsLabel: 'Trash',
  );

  static Widget cameraSvg({double? width, double? height}) => SvgPicture.asset(
    camera,
    width: width,
    height: height,
    semanticsLabel: 'Logo',
  );
  static Widget logoutSvg({double? width, double? height}) => SvgPicture.asset(
    logout,
    width: width,
    height: height,
    semanticsLabel: 'Logo',
  );
  static Widget giftSvg({double? width, double? height}) => SvgPicture.asset(
    gift,
    width: width,
    height: height,
    semanticsLabel: 'Gift',
  );
  static Widget mapPinSvg({double? width, double? height}) => SvgPicture.asset(
    mapPin,
    width: width,
    height: height,
    semanticsLabel: 'Map Pin',
  );
  static Widget creditCardSvg({double? width, double? height}) =>
      SvgPicture.asset(
        creditCard,
        width: width,
        height: height,
        semanticsLabel: 'Credit Card',
      );
  static Widget serverSvg({double? width, double? height}) => SvgPicture.asset(
    server,
    width: width,
    height: height,
    semanticsLabel: 'Server',
  );
  static Widget editSvg({double? width, double? height}) => SvgPicture.asset(
    edit,
    width: width,
    height: height,
    semanticsLabel: 'Edit',
  );
}

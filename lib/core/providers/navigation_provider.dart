import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void setIndex(int i) {
    _index = i;
    notifyListeners();
  }

  void goToCart(BuildContext context) {
    _index = 2;
    notifyListeners();
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

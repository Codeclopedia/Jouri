import 'package:flutter/material.dart';

class CheckoutTabProvider extends ChangeNotifier {
  int currentTabIndex = 0;

  changeCurrentTabValue(int value) {
    currentTabIndex = value;
    notifyListeners();
  }
}

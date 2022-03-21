import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/general.dart';
import '../cart/cart_screen.dart';
import '../cart/cart_view_model.dart';

class AppBarViewModel extends ChangeNotifier {
  final bool withCartButton;
  AppBarViewModel({required this.withCartButton}) {
    calculateCartCount();
  }
  int cartCount = 0;

  void calculateCartCount() {
    cartCount = General.getCartCount();
    notifyListeners();
  }

  navigateToCart(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => CartViewModel(),
              child: const CartScreen(),
            )));
  }
}

import 'package:Jouri/ui/checkout/checkout_view_model.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/general.dart';
import '../cart/cart_screen.dart';
import '../cart/cart_view_model.dart';

class AppBarViewModel extends ChangeNotifier {
  final bool withCartButton;
  AppBarViewModel({required this.withCartButton}) {
    calculateCartCount();
    newCartItemIconLocalValue();
  }
  int cartCount = 0;
  bool newCartItemIcon = false;

  void calculateCartCount() {
    cartCount = General.getCartCount();
    notifyListeners();
  }

  newCartItemIconLocalValue() async {
    final newsharedPrefInstance = await SharedPreferences.getInstance();
    newCartItemIcon = newsharedPrefInstance.getBool('newCartItemIcon') ?? false;
    notifyListeners();
  }

  showNewCartItemIcon(bool status) async {
    newCartItemIcon = status;
    notifyListeners();

    final newsharedPrefInstance = await SharedPreferences.getInstance();
    await newsharedPrefInstance.setBool('newCartItemIcon', status);
  }

  navigateToCart(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => MultiProvider(providers: [
              ChangeNotifierProvider(
                create: (context) => CartViewModel(),
              ),
            ], child: CartScreen())));
  }
}

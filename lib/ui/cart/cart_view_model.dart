import 'dart:convert';

import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../utilities/constants.dart';
import '../../utilities/general.dart';
import '../../utilities/http_requests.dart';

class CartViewModel extends ChangeNotifier {
  var cartProducts = <Product>[];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  Future<List<Product>> loadCart(context) async {
    List<int> cartIds = General.getCartIds();

    var productIdsString = cartIds.map((e) => e).toString();
    productIdsString = productIdsString
        .substring(1, productIdsString.length - 1)
        .replaceAll(', ', ',');
    print('include: $productIdsString');
    var url = Constants.baseUrl +
        Constants.products +
        Constants.wooAuth +
        '&status=publish&per_page=50&include=$productIdsString';
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          cartProducts = [];
          final List list = json.decode(value);
          list.forEach((element) {
            cartProducts.add(Product.fromMap(element));
          });
        },
        error: () {});
    print('cart products count: ${cartProducts.length}');

    return cartProducts;
  }

  String calculatePrice(context) {
    var total = General.getCartPrice(context).toString();

    return (double.parse(total)).toStringAsFixed(2).toString();
  }

  int cartCount = General.getCartCount();

  decrement(Product product, CartItem cartItem, BuildContext context) {
    if (cartItem.quantity > 1) {
      General.decrementCartItem(
        productId: product.id,
      );
      cartItem.quantity = cartItem.quantity;
      print('new quantity: ${cartItem.quantity}');
      HapticFeedback.vibrate();
      // notifyListeners();
    } else {
      General.removeCartItem(productId: product.id);
      cartProducts.removeWhere((element) => element.id == product.id);
      print('${product.id} deleted');
      HapticFeedback.vibrate();
      // notifyListeners();
    }
    calculatePrice(context);
    recalculateCartCount();
  }

  increment(Product product, CartItem cartItem, BuildContext context) {
    if (product.type == 'variable' && cartItem.productDetails != null) {
      if (cartItem.quantity + 1 <=
          cartItem.productDetails.stockQuantity!.toInt()) {
        General.incrementCartItem(
          productId: product.id,
        );
        cartItem.quantity = cartItem.quantity;
        print('new quantity: ${cartItem.quantity}');
        HapticFeedback.vibrate();
        // notifyListeners();
      } else {
        return SnackBar(
            content: Text(
                'not available more than ${cartItem.productDetails.stockQuantity}'));
      }
    } else {
      if (cartItem.quantity + 1 <= int.parse(product.stockQuantity!)) {
        General.incrementCartItem(
          productId: product.id,
        );
        print('new quantity: ${cartItem.quantity}');
        HapticFeedback.vibrate();
        // notifyListeners();
      } else {
        return SnackBar(
            content: Text('not available more than ${product.stockQuantity}'));
      }
    }
    calculatePrice(context);
    recalculateCartCount();
  }

  void recalculateCartCount() {
    cartCount = General.getCartCount();
    print('cart count: $cartCount');
    notifyListeners();
  }
}

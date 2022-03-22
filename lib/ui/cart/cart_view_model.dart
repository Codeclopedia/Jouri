import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/model/cart_model.dart';

import '../../models/product.dart';
import '../../models/product_variation.dart';
import '../../utilities/constants.dart';
import '../../utilities/general.dart';
import '../../utilities/http_requests.dart';

class CartViewModel extends ChangeNotifier {
  var cartProducts = <Product>[];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  Future<List<Product>> loadCart(context) async {
    if (cartProducts.isNotEmpty) return cartProducts;
    List<CartItem> cartItems = General.getCartItems();

    ///
    var productIdsString = cartItems.map((e) => e.productId).toString();
    productIdsString = productIdsString
        .substring(1, productIdsString.length - 1)
        .replaceAll(', ', ',');

    ///
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
          List list = json.decode(value);
          list.forEach((element) {
            cartProducts.add(Product.fromMap(element));
          });
        },
        error: () {});
    print('cart products count: ${cartProducts.length}');
    return cartProducts;
  }

  String calculatePrice() {
    // List<CartItem> cartItems = General.getCartItems();
    //
    // var total = 0.0;
    // cartItems.forEach((element) {
    //   total += element.unitPrice * element.quantity;
    //   General.updateCart(
    //       productId: element.productId,
    //       unitPrice: element.unitPrice,
    //       variation: element.productDetails);
    // });
    //
    // // data.forEach((element) {
    // //   var item = General.getSpecificCart(productId: int.parse(
    // //       // element.translations.ar??
    // //       '${element.id}'));
    // //   item ??= General.getSpecificCart(productId: int.parse(
    // //       // element.translations.en??
    // //       '${element.id}'));
    // //   total += (double.parse(element.price!)) * item!.quantity;
    // //   General.updateCart(
    // //       productId: item.productId, unitPrice: double.parse(element.price!));
    // // });
    // return '$total KD';
    var total = General.getCartPrice().toString();
    return total;
  }

  ///*********************///
  int cartCount = General.getCartCount();

  decrement(Product product, CartItem cartItem) {
    if (cartItem.quantity > 1) {
      General.decrementCartItem(
        productId: product.id,
      );
      cartItem.quantity = cartItem.quantity;
      print('new quantity: ${cartItem.quantity}');
      HapticFeedback.vibrate();
      notifyListeners();
    } else {
      General.removeCartItem(productId: product.id);
      print('${product.id} deleted');
      HapticFeedback.vibrate();
      notifyListeners();
    }
    calculatePrice();
    recalculateCartCount();
  }

  increment(Product product, CartItem cartItem) {
    if (product.type == 'variable' && cartItem.productDetails != null) {
      if (cartItem.quantity + 1 <=
          cartItem.productDetails.stockQuantity!.toInt()) {
        General.incrementCartItem(
          productId: product.id,
        );
        cartItem.quantity = cartItem.quantity;
        print('new quantity: ${cartItem.quantity}');
        HapticFeedback.vibrate();
        notifyListeners();
      } else {
        return SnackBar(
            content: Text(
                'not available more than ${cartItem.productDetails.stockQuantity}'));
      }
    } else {
      if (cartItem.quantity + 1 <= product.stockQuantity!.toInt()) {
        General.incrementCartItem(
          productId: product.id,
        );
        print('new quantity: ${cartItem.quantity}');
        HapticFeedback.vibrate();
        notifyListeners();
      } else {
        return SnackBar(
            content: Text('not available more than ${product.stockQuantity}'));
      }
    }
    calculatePrice();
    recalculateCartCount();
  }

  void recalculateCartCount() {
    cartCount = General.getCartCount();
    print('cart count: $cartCount');
    notifyListeners();
  }

// String calculatePrice() {
//   // List<CartItem> cartItems = General.getCartItems();
//   //
//   // var total = 0.0;
//   // cartItems.forEach((element) {
//   //   total += element.unitPrice * element.quantity;
//   //   General.updateCart(
//   //       productId: element.productId,
//   //       unitPrice: element.unitPrice,
//   //       variation: element.productDetails);
//   // });
//   //
//   // // data.forEach((element) {
//   // //   var item = General.getSpecificCart(productId: int.parse(
//   // //       // element.translations.ar??
//   // //       '${element.id}'));
//   // //   item ??= General.getSpecificCart(productId: int.parse(
//   // //       // element.translations.en??
//   // //       '${element.id}'));
//   // //   total += (double.parse(element.price!)) * item!.quantity;
//   // //   General.updateCart(
//   // //       productId: item.productId, unitPrice: double.parse(element.price!));
//   // // });
//   // return '$total KD';
//   var total = General.getCartPrice().toString();
//   return total;
// }

}

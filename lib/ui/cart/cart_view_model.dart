import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';

import '../../models/product.dart';
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

}

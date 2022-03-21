import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/model/cart_model.dart';
import '../../models/product.dart';
import '../../models/product_variation.dart';
import '../../utilities/general.dart';

class CartCardViewModel extends ChangeNotifier {
  final Product product;
  final CartItem cartItem;
  CartCardViewModel({
    required this.cartItem,
    required this.product,
  }) {
    quantity = cartItem.quantity;
    selectedVariation = cartItem.productDetails;
  }
  int quantity = 1, cartCount = General.getCartCount();
  ProductVariation? selectedVariation;

  decrement() {
    if (quantity > 1) {
      General.decrementCartItem(
        productId: product.id,
      );
      quantity = cartItem.quantity;
      print('new quantity: $quantity');
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

  increment() {
    if (product.type == 'variable' && selectedVariation != null) {
      if (quantity + 1 <= selectedVariation!.stockQuantity!.toInt()) {
        General.incrementCartItem(
          productId: product.id,
        );
        quantity = cartItem.quantity;
        print('new quantity: $quantity');
        HapticFeedback.vibrate();
        notifyListeners();
      } else {
        return SnackBar(
            content: Text(
                'not available more than ${selectedVariation!.stockQuantity}'));
      }
    } else {
      if (quantity + 1 <= product.stockQuantity!.toInt()) {
        General.incrementCartItem(
          productId: product.id,
        );
        quantity = cartItem.quantity;
        print('new quantity: $quantity');
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

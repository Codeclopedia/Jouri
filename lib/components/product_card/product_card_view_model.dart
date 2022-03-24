import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../ui/product_details_screen/product_details_screen.dart';
import '../../ui/product_details_screen/product_details_view_model.dart';
import '../../utilities/general.dart';

class ProductCardViewModel extends ChangeNotifier {
  final Product product;

  ProductCardViewModel({required this.product}) {
    checkIfIsFav();
  }

  bool isFav = false;

  addToFav() {
    isFav = !isFav;
    General.addToFav(product);
    notifyListeners();
  }

  removeFromFav() {
    isFav = !isFav;
    General.removeFromFav(product);
    notifyListeners();
  }

  checkIfIsFav() {
    List<Product> favProducts = General.getFav().toList();
    favProducts.forEach((element) {
      if (element.id == product.id) {
        isFav = true;
        notifyListeners();
      }
    });
  }

  navigateToProductDetailsScreen(context, Product gridItem) {
    var isVariable = gridItem.type == 'variable' ? true : false;
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (BuildContext context) => ChangeNotifierProvider(
        create: (context) =>
            ProductDetailsViewModel(product: gridItem, isVariable: isVariable),
        child: const ProductDetailsScreen(),
      ),
    ));
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../ui/product_details_screen/product_details_screen.dart';
import '../../ui/product_details_screen/product_details_view_model.dart';

class ProductCardViewModel extends ChangeNotifier {
  final Product product;

  ProductCardViewModel({required this.product});

  bool isFav = false;

  addToFav() {
    isFav = !isFav;
    notifyListeners();
  }

  navigateToProductDetailsScreen(context, gridItem) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (BuildContext context) => ChangeNotifierProvider(
        create: (context) => ProductDetailsViewModel(product: gridItem),
        child: const ProductDetailsScreen(),
      ),
    ));
  }
}

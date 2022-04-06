import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../../models/product.dart';
import '../../ui/auth/login/login_screen.dart';
import '../../ui/auth/login/login_view_model.dart';
import '../../ui/product_details_screen/product_details_screen.dart';
import '../../ui/product_details_screen/product_details_view_model.dart';
import '../../utilities/general.dart';

class ProductCardViewModel extends ChangeNotifier {
  final Product product;

  ProductCardViewModel({required this.product}) {
    loadUser();
  }

  bool isFav = false;
  Customer? customer;

  loadUser() async {
    var data = await General.getUser();
    if (data != null) {
      customer = Customer.fromJson(data);
      print('user name is : ${customer!.firstName}');
      checkIfIsFav();
    } else {
      print('user is null');
    }
  }

  addToFav(context) {
    if (customer != null) {
      isFav = !isFav;
      General.addToFav(product);
      HapticFeedback.vibrate();
      notifyListeners();
    } else {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const LocalizedText('productDetailsPage.haveToLogin'),
          action: SnackBarAction(
            label: General.getTranslatedText(context, 'auth.login'),
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => LoginViewModel(),
                        child: LoginScreen(),
                      )));
            },
          ),
        ),
      );
    }
  }

  removeFromFav() {
    isFav = !isFav;
    General.removeFromFav(product);
    HapticFeedback.vibrate();
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

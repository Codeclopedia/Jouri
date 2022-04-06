import 'package:Jouri/models/product.dart';
import 'package:Jouri/utilities/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../product_details_screen/product_details_screen.dart';
import '../../product_details_screen/product_details_view_model.dart';

class FavouriteViewModel extends ChangeNotifier {
  List<Product> favProducts = General.getFav().toList();

  removeFromFav(
    product,
  ) {
    General.removeFromFav(product);
    favProducts.removeWhere((element) => element.id == product.id);
    notifyListeners();
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

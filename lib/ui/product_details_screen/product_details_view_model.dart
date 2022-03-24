import 'dart:convert';

import 'package:Jouri/ui/cart/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/attribute_term.dart';
import '../../models/product.dart';
import '../../models/product_variation.dart';
import '../../utilities/constants.dart';
import '../../utilities/general.dart';
import '../../utilities/http_requests.dart';
import '../cart/cart_view_model.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  final Product product;
  final bool isVariable;

  ProductDetailsViewModel({required this.product, required this.isVariable}) {
    checkIfIsFav();
  }

  List<ProductVariation> loadedVariations = [];
  ProductVariation? selectedVariation;
  int cartCount = 0, quantity = 1;
  var isFav = false;
  var colorAttributeIndexInProduct,
      colorAttributeIndexInVariation,
      selectedColorIndex,
      color = 0xffEC297B;
  List<Product> loadedRelatedProducts = [];
  List<AttributeTerm> loadedColorAttributeTerms = [];
  List<AttributeTerm> usedColorAttributeTerms = [];

  Future<List<ProductVariation>> loadVariations(context, lang) async {
    var url = Constants.baseUrl +
        Constants.products +
        '/${product.id}' +
        Constants.variations +
        Constants.wooAuth +
        '&lang=$lang';
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, map) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedVariations.add(ProductVariation.fromMap(element));
          });
          if (loadedVariations.isNotEmpty) {
            selectedVariation = loadedVariations.first;
            print('initial variation is: ' + selectedVariation!.id.toString());
            notifyListeners();
          } else {
            print('no variations to this product');
          }
        },
        error: () {});

    return loadedVariations;
  }

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
    var favProducts = General.getFav();
    favProducts.forEach((element) {
      if (element.id == product.id) {
        isFav = true;
        notifyListeners();
      }
    });
  }

  ///linking color swatches with variations process
  /// 1. get all color attribute terms
  Future<List<AttributeTerm>> loadColorAttributeTerms(context, lang) async {
    var url = Constants.baseUrl +
        Constants.attributes +
        '/${Constants.colorAttributeId}' +
        Constants.terms +
        Constants.wooAuth +
        '&lang=$lang';
    List<AttributeTerm> loadedData = [];
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(AttributeTerm.fromMap(element));
          });
          loadedColorAttributeTerms = loadedData;
          storeUsedAttribute();
        },
        error: () {});

    return loadedData;
  }

  /// 2. a) find color attribute index in the product attribute list
  getColorAttributeIndexInProduct() {
    colorAttributeIndexInProduct = product.attributes!
        .indexWhere((element) => element.id == Constants.colorAttributeId);
    print('color attribute index in product: ' +
        colorAttributeIndexInProduct.toString());
  }

  /// 2. b) find color attribute index in the variation attribute list
  getColorAttributeIndexInVariation() {
    colorAttributeIndexInVariation = selectedVariation!.attributes!
        .indexWhere((element) => element.id == Constants.colorAttributeId);
    print('color attribute index in variation: ' +
        colorAttributeIndexInProduct.toString());
  }

  /// 3. iterate on color attribute terms to get the terms that have been used in the product variations ( if term.name equals to product.attribute.options ) and store the used terms in new list --> to get term object
  storeUsedAttribute() {
    getColorAttributeIndexInProduct();
    getColorAttributeIndexInVariation();
    if (usedColorAttributeTerms.isEmpty) {
      loadedColorAttributeTerms
          .map((e) => product.attributes![colorAttributeIndexInProduct].options!
                  .map((y) {
                /// e is attribute term,y is product color option
                if (e.name == y) usedColorAttributeTerms.add(e);
              }).toList())
          .toList();
      selectedColorIndex = usedColorAttributeTerms.indexWhere((element) =>
          element.name ==
          selectedVariation!
              .attributes![colorAttributeIndexInVariation].option);
      print("number of colors used in product: " +
          usedColorAttributeTerms.length.toString());
    }
  }

  /// 4. iterate on used attribute terms to get terms equal variation color attribute option --> when change variation
  changeVariation(AttributeTerm colorTerm, y) {
    selectedVariation = loadedVariations.firstWhere((element) =>
        element.attributes![colorAttributeIndexInVariation].option ==
        colorTerm.name);
    selectedColorIndex = y;
    print('new selected variation: ' +
        selectedVariation!.id.toString() +
        ' - ' +
        selectedVariation!.attributes![colorAttributeIndexInVariation].option!);
    notifyListeners();
  }

  /// 5. receive hex code and convert to int
  hexToColor(AttributeTerm hex) {
    if (hex.description != "") {
      var hexColor = hex.description;
      hexColor = hexColor!.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      color = int.parse(hexColor, radix: 16);
    }
  }

  Future<List<Product>> loadRelatedProducts(context, lang) async {
    var ids = product.relatedIds!.map((e) => e).toString();
    ids = ids.substring(1, ids.length - 1).replaceAll(', ', ',');
    var url = Constants.baseUrl +
        Constants.products +
        Constants.wooAuth +
        '&include=$ids&lang=$lang';
    List<Product> loadedData = [];
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(Product.fromMap(element));
          });
          loadedRelatedProducts = loadedData;
        },
        error: () {});

    return loadedData;
  }

  ///add to cart methods
  void recalculateCartCount() {
    cartCount = General.getCartCount();
    notifyListeners();
  }

  addToCart(context) {
    General.addToCart(
        productId: product.id,
        unitPrice: selectedVariation != null && isVariable
            ? double.parse(selectedVariation!.price!)
            : double.parse(product.price!),
        quantity: quantity,
        variation:
            selectedVariation != null && isVariable ? selectedVariation : null);
    HapticFeedback.vibrate();
    recalculateCartCount();
  }

  decrement() {
    if (quantity > 1) {
      // General.decrementCartItem(
      //   productId: selectedVariation != null && isVariable
      //       ? selectedVariation!.id
      //       : product.id,
      // );
      quantity--;
      print('current quantity: $quantity');
      HapticFeedback.vibrate();
      notifyListeners();
    } else {
      null;
    }
    // recalculateCartCount();
  }

  increment() {
    // General.incrementCartItem(
    //   productId: selectedVariation != null && isVariable
    //       ? selectedVariation!.id
    //       : product.id,
    // );
    if (isVariable) {
      if (quantity + 1 <= selectedVariation!.stockQuantity!.toInt()) {
        quantity++;
        print('current quantity: $quantity');
        HapticFeedback.vibrate();
        notifyListeners();
      } else {
        return SnackBar(content: Text('not available more than $quantity'));
      }
    } else {
      if (quantity + 1 <= product.stockQuantity!.toInt()) {
        quantity++;
        print('current quantity: $quantity');
        HapticFeedback.vibrate();
        notifyListeners();
      } else {
        return SnackBar(content: Text('not available more than $quantity'));
      }
    }

    // recalculateCartCount();
  }

  navigateToCart(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => CartViewModel(),
              child: const CartScreen(),
            )));
  }
}

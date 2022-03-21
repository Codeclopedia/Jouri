import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../models/mobile_banner.dart';
import '../../../../models/product.dart';
import '../../../../utilities/constants.dart';
import '../../../../utilities/http_requests.dart';
import '../../../product_archive_screen/product_archive_screen.dart';
import '../../../product_archive_screen/product_archive_view_model.dart';
import '../../../product_details_screen/product_details_screen.dart';
import '../../../product_details_screen/product_details_view_model.dart';

class LatestProductsTabViewModel extends ChangeNotifier {
  List<MobileBanner> loadedBanners = [];
  List<Product> loadedProducts = [];

  Future<List<MobileBanner>> loadMobileBanners(context, lang) async {
    var url = Constants.baseUrl +
        Constants.mobileBanners +
        Constants.wooAuth +
        '?lang=$lang';
    List<MobileBanner> loadedData = [];
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(MobileBanner.fromMap(element));
          });
          loadedBanners = loadedData;
        },
        error: () {});

    return loadedData;
  }

  Future<List<Product>> loadProducts(context, lang) async {
    var url = Constants.baseUrl +
        Constants.products +
        Constants.wooAuth +
        '&per_page=18&orderby=date&order=desc&lang=$lang';
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
          loadedProducts = loadedData;
        },
        error: () {});

    return loadedData;
  }

  navigateToArchiveScreen(context, name) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductArchiveViewModel(
                tag: false,
                category: false,
                attribute: false,
                allProducts: true,
                name: name,
              ),
              child: const ProductArchiveScreen(),
            )));
  }

  navigateToProductDetailsScreen(context,Product gridItem) {
    var isVariable=gridItem.type=='variable'?true:false;
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (BuildContext context) => ChangeNotifierProvider(
        create: (context) => ProductDetailsViewModel(product: gridItem,isVariable: isVariable),
        child: const ProductDetailsScreen(),
      ),
    ));
  }
}

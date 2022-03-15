import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../models/mobile_banner.dart';
import '../../../../models/product.dart';
import '../../../../models/tag.dart';
import '../../../../utilities/constants.dart';
import '../../../../utilities/http_requests.dart';

class CollectionsTabViewModel extends ChangeNotifier {
  List<MobileBanner> loadedBanners = [];
  List<Tag> loadedTags = [];
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

  Future<List<Tag>> loadTags(context, lang) async {
    var url =
        Constants.baseUrl + Constants.tags + Constants.wooAuth + '&lang=$lang';
    List<Tag> loadedData = [];
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(Tag.fromMap(element));
          });
          loadedTags = loadedData;
        },
        error: () {});

    return loadedData;
  }

  Future<List<Product>> loadProducts(context, lang) async {
    var url = Constants.baseUrl +
        Constants.products +
        Constants.wooAuth +
        '&per_page=6&orderby=date&order=desc&lang=$lang';
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
}

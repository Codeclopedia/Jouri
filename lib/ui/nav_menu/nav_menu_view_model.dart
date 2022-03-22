import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../utilities/constants.dart';
import '../../utilities/http_requests.dart';
import '../product_archive_screen/product_archive_screen.dart';
import '../product_archive_screen/product_archive_view_model.dart';

class NavMenuViewModel extends ChangeNotifier {
  List<Category> loadedCategories = [];

  Future<List<Category>> loadCategories(context, lang) async {
    List<Category> loadedData = [];
    var url = Constants.baseUrl +
        Constants.categories +
        Constants.wooAuth +
        '&hide_empty=true&parent=0&per_page=100&lang=$lang';
    print(url);
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(Category.fromMap(element));
          });
          loadedCategories = loadedData;
        },
        error: () {});
    return loadedData;
  }

  Future<List<Category>> loadSubCategory(context, catId, lang) async {
    var url = Constants.baseUrl +
        Constants.categories +
        Constants.wooAuth +
        '&hide_empty=true&parent=$catId&lang=$lang';
    List<Category> loadedData = [];
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(Category.fromMap(element));
          });
        },
        error: () {});

    return loadedData;
  }

  navigateToArchiveScreen(context, id, catName, catDescription, parentCat) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductArchiveViewModel(
                  tag: false,
                  category: true,
                  attribute: false,
                  allProducts: false,
                  onSale: false,
                  id: id,
                  name: catName,
                  description: catDescription,
                  parentCat: parentCat),
              child: const ProductArchiveScreen(),
            )));
  }
}

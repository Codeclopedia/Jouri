import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../models/product.dart';
import '../../utilities/constants.dart';
import '../../utilities/http_requests.dart';
import '../bottom_sheets/filter_bottom_sheet.dart';
import '../bottom_sheets/sort_bottom_sheet.dart';

class ProductArchiveViewModel extends ChangeNotifier {
  final bool tag, category, attribute, latest, onSale;
  final int? archiveId;
  final String? archiveName, archiveDescription, parentCat;

  bool loading = false;

  ProductArchiveViewModel(
      {required this.tag,
      required this.category,
      required this.attribute,
      required this.latest,
      required this.onSale,
      this.archiveId,
      this.archiveName,
      this.archiveDescription,
      this.parentCat});

  List<Product> loadedProducts = [];
  var page = 1;
  var totalPage = 1;
  String? sort, priceRange;
  int? sortData;
  bool saving = false;
  SfRangeValues? priceRangeData;

  Future<List<Product>> loadProducts(context, lang) async {
    var url;

    /// product by category
    if (category) {
      url = Constants.baseUrl +
          Constants.products +
          Constants.wooAuth +
          '&category=$archiveId&lang=$lang';

      /// product by tag
    } else if (tag) {
      url = Constants.baseUrl +
          Constants.products +
          Constants.wooAuth +
          '&tag=$archiveId&lang=$lang';

      /// product by attribute
    } else if (attribute) {
      url = Constants.baseUrl +
          Constants.products +
          Constants.wooAuth +
          '&${Constants.productByFabricAttributeTerm}$archiveId&lang=$lang';

      /// all products
    } else if (latest) {
      url = Constants.baseUrl +
          Constants.products +
          Constants.wooAuth +
          '&lang=$lang';
    } else if (onSale) {
      url = Constants.baseUrl +
          Constants.products +
          Constants.wooAuth +
          '&on_sale=true&lang=$lang';
    }

    url += sort ?? '';
    url += priceRange ?? '';
    if (loadedProducts.isNotEmpty) return loadedProducts;
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, map) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedProducts.add(Product.fromMap(element));
          });
          totalPage = int.parse(map[Constants.totalPagesKey] ?? '1');
          print('total pages: $totalPage');
          // notifyListeners();
        },
        error: () {});

    return loadedProducts;
  }

  loadMore(context, lang) async {
    if (page != totalPage && page < totalPage) {
      loading = true;
      notifyListeners();
      page++;
      var url;
      if (category) {
        url = Constants.baseUrl +
            Constants.products +
            Constants.wooAuth +
            '&category=$archiveId&page=$page&lang=$lang';
      } else if (tag) {
        url = Constants.baseUrl +
            Constants.tags +
            '/$archiveId' +
            Constants.wooAuth +
            '&tag=$archiveId&page=$page&lang=$lang';
      } else if (attribute) {
        url = Constants.baseUrl +
            Constants.products +
            Constants.wooAuth +
            '&${Constants.productByFabricAttributeTerm}$archiveId&page=$page&lang=$lang';
      } else if (latest) {
        url = Constants.baseUrl +
            Constants.products +
            Constants.wooAuth +
            '&page=$page&lang=$lang';
      } else if (onSale) {
        url = Constants.baseUrl +
            Constants.products +
            Constants.wooAuth +
            '&on_sale=true&page=$page&lang=$lang';
      }
      saving = true;
      await HttpRequests.httpGetRequest(
          context: context,
          url: url,
          headers: {},
          success: (value, _) {
            List list = json.decode(value);
            list.forEach((element) {
              loadedProducts.add(Product.fromMap(element));
            });
          },
          error: () {});
      saving = false;
      loading = false;
      notifyListeners();
    }
  }

  sortProduct(context) async {
    sortData = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SortBottomSheet(
        sortValue: sortData,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 5,
      expand: false,
      enableDrag: true,
    );
    if (sortData != null) _reSort(sortData!);
  }

  void _reSort(int sortData) {
    var sortIndexes = [
      '&orderby=date&order=desc',
      '&orderby=date&order=asc',
      '&orderby=price&order=desc',
      '&orderby=price&order=asc'
    ];
    loadedProducts.clear();
    sort = sortIndexes[sortData];
    notifyListeners();
  }

  filterProduct(context, SfRangeValues rangeData) async {
    priceRangeData = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => FilterBottomSheet(
        data: rangeData,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 5,
      expand: false,
      enableDrag: true,
    );
    _addPriceRange(priceRangeData);
  }

  void _addPriceRange(SfRangeValues? priceRangeData) {
    if (priceRangeData == null) {
      loadedProducts.clear();
      priceRange = null;
      notifyListeners();
    } else if (priceRangeData.start != priceRangeData.end) {
      loadedProducts.clear();
      priceRange =
          '&max_price=${priceRangeData.end}&min_price=${priceRangeData.start}';
      notifyListeners();
    }
  }
}

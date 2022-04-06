import 'dart:convert';

import 'package:Jouri/ui/account/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../../models/customer.dart';
import '../../utilities/constants.dart';
import '../../utilities/general.dart';
import '../../utilities/http_requests.dart';
import '../account/favourites/favourite_screen.dart';
import '../account/favourites/favourite_view_model.dart';
import '../account/orders/orders_screen.dart';
import '../account/orders/orders_view_model.dart';
import '../account/profile/profile_screen.dart';
import '../auth/login/login_screen.dart';
import '../auth/login/login_view_model.dart';
import '../product_archive/product_archive_screen.dart';
import '../product_archive/product_archive_view_model.dart';

class NavMenuViewModel extends ChangeNotifier {
  NavMenuViewModel() {
    loadUser();
  }
  List<Category> loadedCategories = [];
  Customer? customer;

  loadUser() async {
    var data = await General.getUser();
    if (data != null) {
      customer = Customer.fromJson(data);
      notifyListeners();
      print('user name is : ${customer!.firstName}');
    } else {
      print('user is null');
    }
  }

  logOut() {
    General.clearSP('user');
    customer = null;
    notifyListeners();
  }

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

  navigateToArchiveScreenAsCategory(
      context, id, catName, catDescription, parentCat) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductArchiveViewModel(
                  tag: false,
                  category: true,
                  attribute: false,
                  latest: false,
                  onSale: false,
                  archiveId: id,
                  archiveName: catName,
                  archiveDescription: catDescription,
                  parentCat: parentCat),
              child: const ProductArchiveScreen(),
            )));
  }

  navigateToArchiveScreenAsOnSale(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductArchiveViewModel(
                tag: false,
                category: false,
                attribute: false,
                latest: false,
                onSale: true,
              ),
              child: const ProductArchiveScreen(),
            )));
  }

  navigateToFavourite(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => FavouriteViewModel(),
              child: const FavouriteScreen(),
            )));
  }

  navigateToLogin(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginViewModel(),
              child: const LoginScreen(),
            )));
  }

  navigateToOrders(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => OrdersViewModel(customer: customer),
              child: const OrdersScreen(),
            )));
  }

  navigateToProfile(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProfileViewModel(),
              child: const ProfileScreen(),
            )));
  }
}

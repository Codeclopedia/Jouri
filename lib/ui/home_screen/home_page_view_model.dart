import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  var latest = true, collections = false, fabrics = false, onSale = false;

  callLatestProductsTab(context) {
    latest = true;
    collections = false;
    onSale = false;
    fabrics = false;
    notifyListeners();
  }

  callCollectionsTab(context) {
    collections = true;
    latest = false;
    onSale = false;
    fabrics = false;
    notifyListeners();
  }

  callFabricsTab(context) {
    fabrics = true;
    latest = false;
    onSale = false;
    collections = false;
    notifyListeners();
  }

  callOnSaleTab(context) {
    onSale = true;
    latest = false;
    fabrics = false;
    collections = false;
    notifyListeners();
  }
}

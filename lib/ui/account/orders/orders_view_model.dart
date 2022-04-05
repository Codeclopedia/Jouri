import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/customer.dart';
import '../../../models/order.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/http_requests.dart';

class OrdersViewModel extends ChangeNotifier {
  final Customer? customer;
  OrdersViewModel({this.customer});

  List<Order> loadedOrders = [];

  Future<List<Order>> loadOrders(context, lang) async {
    var url = Constants.baseUrl +
        Constants.orders +
        Constants.wooAuth +
        '&customer=${customer!.id}&lang=$lang';
    List<Order> loadedData = [];
    await HttpRequests.httpGetRequest(
        context: context,
        url: url,
        headers: {},
        success: (value, _) {
          List list = json.decode(value);
          list.forEach((element) {
            loadedData.add(Order.fromMap(element));
          });
          loadedOrders = loadedData;
        },
        error: () {});

    return loadedData;
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../models/attribute_term.dart';
import '../../../../utilities/constants.dart';
import '../../../../utilities/http_requests.dart';
import '../../../product_archive/product_archive_screen.dart';
import '../../../product_archive/product_archive_view_model.dart';

class FabricsTabViewModel extends ChangeNotifier {
  List<AttributeTerm> loadedAttributeTerms = [];

  Future<List<AttributeTerm>> loadAttributeTerms(context, lang) async {
    var url = Constants.baseUrl +
        Constants.attributes +
        '/${Constants.fabricAttributeId}' +
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
          loadedAttributeTerms = loadedData;
        },
        error: () {});

    return loadedData;
  }

  navigateToArchiveScreen(context, id, fabricName, fabricDescription) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductArchiveViewModel(
                  tag: false,
                  category: false,
                  attribute: true,
                  latest: false,
                  onSale: false,
                  archiveId: id,
                  archiveName: fabricName,
                  archiveDescription: fabricDescription),
              child: const ProductArchiveScreen(),
            )));
  }
}

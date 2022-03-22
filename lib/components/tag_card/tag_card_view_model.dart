import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../ui/product_archive_screen/product_archive_screen.dart';
import '../../ui/product_archive_screen/product_archive_view_model.dart';

class TagCardViewModel extends ChangeNotifier {
  navigateToArchiveScreen(
    context,
    id,
    tagName,
  ) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductArchiveViewModel(
                tag: true,
                category: false,
                attribute: false,
                allProducts: false,
                onSale: false,
                id: id,
                name: tagName,
              ),
              child: const ProductArchiveScreen(),
            )));
  }
}

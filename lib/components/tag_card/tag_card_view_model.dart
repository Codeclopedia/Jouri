import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import '../../ui/product_archive/product_archive_screen.dart';
import '../../ui/product_archive/product_archive_view_model.dart';

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
                latest: false,
                onSale: false,
                archiveId: id,
                archiveName: tagName,
              ),
              child: const ProductArchiveScreen(),
            )));
  }
}

import 'package:Jouri/ui/product_archive_screen/product_archive_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/product_card/product_card.dart';
import '../../components/product_card/product_card_view_model.dart';
import '../../components/product_loading.dart';
import '../../models/product.dart';

class ProductArchiveScreen extends StatelessWidget {
  const ProductArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var archiveData = Provider.of<ProductArchiveViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var tagStyle = const TextStyle(
      color: Colors.white,
      fontSize: 13,
    );
    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 21,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 4.2,
    );
    var descriptionStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    );

    var buttonTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 2.8,
    );

    var breadcrumbsStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 1.4,
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          color: Theme.of(context).primaryColor,
          child: const Text(
            'Free Shipping above 20 KD',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11, letterSpacing: 2.2, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bag,
                color: Theme.of(context).primaryColor,
              ))
        ],
        title: Image.asset(
          'assets/images/logo.png',
          width: 50,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            ///name and description -- for tags and attribute terms (fiber)
            archiveData.tag || archiveData.attribute
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        archiveData.name!,
                        style: titleStyle,
                        textAlign: TextAlign.center,
                      ),
                      // !archiveData.attribute && archiveData.description != null
                      //     ? Column(
                      //         children: [
                      //           const SizedBox(
                      //             height: 15,
                      //           ),
                      //           Text(
                      //             archiveData.description!,
                      //             style: descriptionStyle,
                      //             textAlign: TextAlign.center,
                      //           ),
                      //           const SizedBox(
                      //             height: 20,
                      //           ),
                      //         ],
                      //       )
                      //     : Container(),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                    ],
                  )
                : Container(),
            archiveData.allProducts
                ? LocalizedText(
                    '${archiveData.name}',
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  )
                : Container(),

            ///breadcrumbs -- for category and sub-category
            archiveData.category
                ? archiveData.parentCat != null
                    ? Row(
                        children: [
                          Text(
                            archiveData.parentCat!,
                            style: breadcrumbsStyle,
                          ),
                          const Text(' / '),
                          Text(
                            archiveData.name!,
                            style: breadcrumbsStyle,
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            archiveData.name!,
                            style: breadcrumbsStyle,
                          ),
                        ],
                      )
                : Container(),
            const SizedBox(
              height: 20,
            ),

            ///filter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                  onPressed: () {
                    archiveData.filterProduct(context);
                  },
                  child: LocalizedText(
                    'productArchive.filter',
                    style: buttonTextStyle,
                  ),
                ),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                  onPressed: () {
                    // onSaleTabData.loadMore(context);
                    archiveData.sortProduct(context);
                  },
                  child: LocalizedText(
                    'productArchive.sort',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            ///grid
            archiveData.loadedProducts.isEmpty
                ? FutureBuilder<List<Product>>(
                    future: archiveData.loadProducts(context, currentLang),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChangeNotifierProvider(
                              create: (context) => ProductCardViewModel(
                                  product: snapshot.data![index]),
                              child: ProductCard(
                                gridItem: snapshot.data![index],
                                currentLang: currentLang,
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 16,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                          ),
                        );
                      } else {
                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 16,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          shrinkWrap: true,
                          primary: true,
                          children: const [
                            ProductLoading(),
                            ProductLoading(),
                            ProductLoading(),
                            ProductLoading(),
                          ],
                        );
                      }
                    })
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: archiveData.loadedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider(
                        create: (context) => ProductCardViewModel(
                            product: archiveData.loadedProducts[index]),
                        child: ProductCard(
                          gridItem: archiveData.loadedProducts[index],
                          currentLang: currentLang,
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 16,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15),
                  ),
            const SizedBox(
              height: 30,
            ),
            archiveData.page != archiveData.totalPage ||
                    archiveData.totalPage > 1
                ? Column(
                    children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                              onPressed: () {
                                archiveData.loadMore(context, currentLang);
                              },
                              child: const LocalizedText(
                                  'productArchive.loadMore'))),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

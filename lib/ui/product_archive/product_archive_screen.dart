import 'package:Jouri/components/loading.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:Jouri/ui/product_archive/product_archive_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../components/product_card/product_card.dart';
import '../../components/product_card/product_card_view_model.dart';
import '../../components/product_loading.dart';
import '../../models/product.dart';
import '../../utilities/general.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/app_bar_view_model.dart';
import '../cart/cart_view_model.dart';

class ProductArchiveScreen extends StatelessWidget {
  const ProductArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var archiveData = Provider.of<ProductArchiveViewModel>(context);
    var currentLang = General.getLanguage(context);

    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 22,
      letterSpacing: 4.2,
    );
    var descriptionStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: Theme.of(context).primaryColor,
      fontSize: 14,
    );

    var buttonTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      letterSpacing: 2.8,
    );

    var breadcrumbsStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 16,
      letterSpacing: 1.4,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff8f9ff),
        body: Column(
          children: [
            /// app bar
            // ChangeNotifierProvider(
            //     create: (context) => AppBarViewModel(withCartButton: true),
            //     child: const AppBarSection()),
            MultiProvider(providers: [
              ChangeNotifierProvider(
                create: (context) => AppBarViewModel(withCartButton: true),
              ),
              ChangeNotifierProvider(
                create: (context) => CartViewModel(),
              ),
            ], child: const AppBarSection()),
            const SizedBox(
              height: 10,
            ),

            /// body
            ///name and description -- for tags and attribute terms (fiber)
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Column(
                    children: [
                      archiveData.tag || archiveData.attribute
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  archiveData.archiveName!,
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
                      archiveData.latest
                          ? LocalizedText(
                              'homePage.newIn',
                              style: titleStyle,
                              textAlign: TextAlign.center,
                            )
                          : Container(),
                      archiveData.onSale
                          ? LocalizedText(
                              'navMenu.onSale',
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
                                      archiveData.archiveName!,
                                      style: breadcrumbsStyle,
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      archiveData.archiveName!,
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
                          Expanded(
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                              onPressed: () {
                                print(
                                    "range data ${archiveData.priceRangeData}");
                                archiveData.filterProduct(
                                    context,
                                    archiveData.priceRangeData ??
                                        SfRangeValues(0, 10));
                              },
                              child: LocalizedText(
                                'productArchivePage.filter',
                                style: buttonTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                              onPressed: () {
                                // onSaleTabData.loadMore(context);
                                archiveData.sortProduct(context);
                              },
                              child: LocalizedText(
                                'productArchivePage.sort',
                                style: buttonTextStyle,
                              ),
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
                              future: archiveData.loadProducts(
                                  context, currentLang),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data!.isNotEmpty
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics: const ScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ChangeNotifierProvider(
                                                    create: (context) =>
                                                        ProductCardViewModel(
                                                            product: snapshot
                                                                .data![index]),
                                                    child: ProductCard(
                                                      gridItem:
                                                          snapshot.data![index],
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
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: 400,
                                          child: Center(
                                            child: Lottie.asset(
                                              'assets/lottie/no_products.json',
                                              repeat: false,
                                              alignment: Alignment.center,
                                              width: 200,
                                            ),
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
                          : archiveData.loadedProducts.isNotEmpty
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: archiveData.loadedProducts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ChangeNotifierProvider(
                                      create: (context) => ProductCardViewModel(
                                          product: archiveData
                                              .loadedProducts[index]),
                                      child: ProductCard(
                                        gridItem:
                                            archiveData.loadedProducts[index],
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
                                )
                              : Container(
                                  height: 400,
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/lottie/no_products.json',
                                      repeat: false,
                                      alignment: Alignment.center,
                                      width: 200,
                                    ),
                                  ),
                                ),
                      const SizedBox(
                        height: 30,
                      ),
                      archiveData.page != archiveData.totalPage &&
                              archiveData.totalPage > 1
                          ? Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (!archiveData.loading)
                                        archiveData.loadMore(
                                            context, currentLang);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: archiveData.loading
                                            ? Colors.white
                                            : null),
                                    child: archiveData.loading
                                        ? Loading()
                                        : const LocalizedText(
                                            'productArchivePage.loadMore'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

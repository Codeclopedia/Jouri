import 'package:Jouri/ui/home_screen/tabs/on_sale_tab/on_sale_tab_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../components/product_card/product_card.dart';
import '../../../../components/product_card/product_card_view_model.dart';
import '../../../../components/product_loading.dart';
import '../../../../models/product.dart';

class OnSaleTab extends StatelessWidget {
  const OnSaleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onSaleTabData = Provider.of<OnSaleTabViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var tagStyle = const TextStyle(
      color: Colors.white,
      fontSize: 13,
    );
    var buttonTextStyle = const TextStyle(
      color: Color(0xff231f20),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 2.8,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          ///filter buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                onPressed: () {
                  onSaleTabData.filterProduct(context);
                },
                child: LocalizedText(
                  'productArchivePage.filter',
                  style: buttonTextStyle,
                ),
              ),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                onPressed: () {
                  // onSaleTabData.loadMore(context);
                  onSaleTabData.sortProduct(context);
                },
                child: LocalizedText(
                  'productArchivePage.sort',
                  style: buttonTextStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          onSaleTabData.loadedProducts.isEmpty
              ? FutureBuilder<List<Product>>(
                  future: onSaleTabData.loadProducts(context, currentLang),
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
                                crossAxisSpacing: 15),
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
                  itemCount: onSaleTabData.loadedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider(
                      create: (context) => ProductCardViewModel(
                          product: onSaleTabData.loadedProducts[index]),
                      child: ProductCard(
                        gridItem: onSaleTabData.loadedProducts[index],
                        currentLang: currentLang,
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 16,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15),
                ),
          const SizedBox(
            height: 30,
          ),
          onSaleTabData.page != onSaleTabData.totalPage &&
                  onSaleTabData.totalPage > 1
              ? Column(
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () {
                              onSaleTabData.loadMore(context);
                            },
                            child: const LocalizedText(
                                'productArchivePage.loadMore'))),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

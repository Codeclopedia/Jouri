import 'package:Jouri/ui/home/tabs/latest_products_tab/latest_products_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../components/loading.dart';
import '../../../../components/product_loading.dart';
import '../../../../models/mobile_banner.dart';
import '../../../../models/product.dart';

class LatestProductsTab extends StatelessWidget {
  const LatestProductsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var latestProductsTabData =
        Provider.of<LatestProductsTabViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();

    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 21,
      fontWeight: FontWeight.w500,
      letterSpacing: 4.2,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          ///banner
          latestProductsTabData.loadedBanners.isEmpty
              ? FutureBuilder<List<MobileBanner>>(
                  future: latestProductsTabData.loadMobileBanners(
                      context, currentLang),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ImageSlideshow(
                          width: double.infinity,
                          isLoop: true,
                          initialPage: 0,
                          indicatorColor:
                              Theme.of(context).colorScheme.secondary,
                          autoPlayInterval: 4000,
                          children: snapshot.data!
                              .map((item) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item.featuredMedia!.large!,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Loading(),
                      );
                    }
                  },
                )
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ImageSlideshow(
                    width: double.infinity,
                    isLoop: true,
                    initialPage: 0,
                    indicatorColor: Theme.of(context).colorScheme.secondary,
                    autoPlayInterval: 4000,
                    children: latestProductsTabData.loadedBanners
                        .map((item) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.featuredMedia!.large!,
                                fit: BoxFit.cover,
                              ),
                            ))
                        .toList(),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),

          ///latest products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: LocalizedText(
                  'homePage.latestProducts',
                  style: titleStyle,
                ),
              ),
              TextButton(
                child: LocalizedText('homePage.shopNow',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
                onPressed: () {
                  latestProductsTabData.navigateToArchiveScreen(
                    context,
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          latestProductsTabData.loadedProducts.isEmpty
              ? FutureBuilder<List<Product>>(
                  future:
                      latestProductsTabData.loadProducts(context, currentLang),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 9 / 16,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: snapshot.data![index].images!.isNotEmpty
                                  ? Image.network(
                                      '${snapshot.data![index].images!.first.src}',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/hijab_placeholder.jpg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            onTap: () {
                              latestProductsTabData
                                  .navigateToProductDetailsScreen(
                                      context, snapshot.data![index]);
                            },
                          );
                        },
                      );
                    } else {
                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 9 / 16,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        primary: true,
                        children: const [
                          ProductLoading(),
                          ProductLoading(),
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
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 9 / 16,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: latestProductsTabData.loadedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: latestProductsTabData
                                .loadedProducts[index].images!.isNotEmpty
                            ? Image.network(
                                '${latestProductsTabData.loadedProducts[index].images!.first.src}',
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/hijab_placeholder.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                      onTap: () {
                        latestProductsTabData.navigateToProductDetailsScreen(
                            context,
                            latestProductsTabData.loadedProducts[index]);
                      },
                    );
                  },
                ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

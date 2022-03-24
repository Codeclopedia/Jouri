import 'package:Jouri/ui/favourites/favourite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/product_card/product_card.dart';
import '../../components/product_card/product_card_view_model.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/app_bar_view_model.dart';
import '../cart/cart_view_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favData = Provider.of<FavouriteViewModel>(context);
    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 21,
      fontWeight: FontWeight.w500,
      letterSpacing: 4.2,
    );
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var currency = currentLang == 'ar' ? 'د.ك' : 'DK';
    var itemTitleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 2.2,
      // height: 10,
    );
    var itemPriceStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontFamily: 'OpenSans',
      fontSize: 12.5,
      fontWeight: FontWeight.w400,
      letterSpacing: 2.8,
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// app bar
              // ChangeNotifierProvider(
              //     create: (context) => AppBarViewModel(withCartButton: true),
              //     child: const AppBarSection()),
              // const SizedBox(
              //   height: 20,
              // ),
              MultiProvider(providers: [
                ChangeNotifierProvider(
                  create: (context) => AppBarViewModel(withCartButton: true),
                ),
                ChangeNotifierProvider(
                  create: (context) => CartViewModel(),
                ),
              ], child: const AppBarSection()),

              /// body
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    LocalizedText(
                      'navMenu.favourite',
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ///grid
                    favData.favProducts.isEmpty
                        ? Container(
                            height: 500,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LocalizedText(
                                  'favouritePage.emptyFavourite',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 3.2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset('assets/images/empty_wishlist.png',
                                    height: 100,
                                    color:
                                        Theme.of(context).colorScheme.secondary)
                              ],
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: favData.favProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool isFav = true;
                              return InkWell(
                                onTap: () {
                                  favData.navigateToProductDetailsScreen(
                                      context, favData.favProducts[index]);
                                },
                                child: Container(
                                  width: 155,
                                  height: 228,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ///slider
                                      Stack(
                                        children: [
                                          favData.favProducts[index].images!
                                                  .isNotEmpty
                                              ? ImageSlideshow(
                                                  // width: 155,
                                                  height: 230,
                                                  initialPage: 0,
                                                  indicatorColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  indicatorBackgroundColor:
                                                      Colors.grey,
                                                  autoPlayInterval: 0,
                                                  children: favData
                                                      .favProducts[index]
                                                      .images!
                                                      .map((e) => ClipRRect(
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5)),
                                                            child:
                                                                Image.network(
                                                              e.src!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ))
                                                      .toList())
                                              : Image.asset(
                                                  'assets/images/hijab_placeholder.jpg',
                                                  height: 230,
                                                  fit: BoxFit.cover,
                                                ),
                                          Align(
                                            child: Stack(
                                              children: [
                                                IconButton(
                                                    icon: const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                      size: 29,
                                                    ),
                                                    onPressed: () {}),
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: isFav
                                                          ? Colors.red
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      isFav = !isFav;
                                                      favData.removeFromFav(
                                                          favData.favProducts[
                                                              index]);
                                                    }),
                                              ],
                                            ),
                                            alignment: Alignment.topRight,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),

                                      ///title
                                      Flexible(
                                        child: Text(
                                          favData.favProducts[index].name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: itemTitleStyle,
                                          textAlign: currentLang == 'ar'
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        ),
                                      ),

                                      ///price
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                favData.favProducts[index]
                                                        .regularPrice! +
                                                    currency,
                                                style: favData
                                                                .favProducts[
                                                                    index]
                                                                .onSale !=
                                                            null &&
                                                        favData
                                                                .favProducts[
                                                                    index]
                                                                .onSale ==
                                                            true
                                                    ? itemPriceStyle.copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)
                                                    : itemPriceStyle,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              favData.favProducts[index]
                                                          .onSale ==
                                                      true
                                                  ? Text(
                                                      favData.favProducts[index]
                                                              .salePrice! +
                                                          currency,
                                                      style: itemPriceStyle
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xffc91f1f)),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

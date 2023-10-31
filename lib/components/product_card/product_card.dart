import 'package:Jouri/components/product_card/product_card_view_model.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:Jouri/utilities/general.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:provider/provider.dart';

import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.gridItem,
    required this.currentLang,
  }) : super(key: key);

  final Product gridItem;
  final String currentLang;

  @override
  Widget build(BuildContext context) {
    var productCard = Provider.of<ProductCardViewModel>(context, listen: false);

    var currency = General.getCurrency(context);
    var itemTitleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 2.2,
      // height: 10,
    );
    var itemPriceStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontFamily: 'OpenSans',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 2.8,
    );

    return InkWell(
      onTap: () {
        productCard.navigateToProductDetailsScreen(context, gridItem);
      },
      child: Container(
        width: 155,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///slider
            Stack(
              children: [
                gridItem.images!.isNotEmpty
                    ? ImageSlideshow(
                        // width: 155,
                        // height: 230,
                        initialPage: 0,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorBackgroundColor: Colors.grey,
                        autoPlayInterval: 0,
                        isLoop: true,
                        children: gridItem.images!
                            .map((e) => ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  child: CachedNetworkImage(
                                    imageUrl: e.src!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ) /* Image.network(
                                      e.src!,
                                      fit: BoxFit.cover,
                                    ) */
                                  ,
                                ))
                            .toList())
                    : Image.asset(
                        'assets/images/hijab_placeholder.jpg',
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                Consumer<ProductCardViewModel>(
                    builder: (context, viewModel, __) {
                  return Align(
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
                            color: productCard.isFav
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            if (!viewModel.isFav) {
                              viewModel.addToFav(context);
                            } else {
                              viewModel.removeFromFav();
                            }
                          },
                        ),
                      ],
                    ),
                    alignment: Alignment.topRight,
                  );
                })
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            ///title
            Text(
              gridItem.name! + '\n',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: itemTitleStyle,
              textAlign: currentLang == 'ar' ? TextAlign.right : TextAlign.left,
            ),

            SizedBox(
              height: 5,
            ),

            ///price
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    gridItem.onSale ?? false
                        ? "${General().selectedCurrencyPrice(price: gridItem.regularPrice, rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}"
                        : "${General().selectedCurrencyPrice(price: gridItem.price, rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}",
                    style: gridItem.onSale != null && gridItem.onSale == true
                        ? itemPriceStyle.copyWith(
                            decoration: TextDecoration.lineThrough)
                        : itemPriceStyle,
                  ),
                  gridItem.onSale == true
                      ? Text(
                          "${General().selectedCurrencyPrice(price: gridItem.salePrice, rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}",
                          style: itemPriceStyle.copyWith(
                              color: const Color(0xffc91f1f)),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

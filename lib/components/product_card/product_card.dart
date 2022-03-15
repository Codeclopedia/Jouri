import 'package:Jouri/components/product_card/product_card_view_model.dart';
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

  var itemTitleStyle = const TextStyle(
    color: Color(0xff000000),
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 2.2,
    // height: 10,
  );
  var itemPriceStyle = const TextStyle(
    color: Color(0xff404041),
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 2.8,
  );

  @override
  Widget build(BuildContext context) {
    var productGridItemData =
        Provider.of<ProductCardViewModel>(context, listen: false);
    var currency = currentLang == 'ar' ? 'د.ك' : 'DK';

    return InkWell(
      onTap: () {
        productGridItemData.navigateToProductDetailsScreen(context, gridItem);
      },
      child: Container(
        width: 155,
        height: 228,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///slider
            Stack(
              children: [
                ImageSlideshow(
                    // width: 155,
                    height: 230,
                    initialPage: 0,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorBackgroundColor: Colors.grey,
                    autoPlayInterval: 0,
                    children: gridItem.images!
                        .map((e) => ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                e.src!,
                                fit: BoxFit.cover,
                              ),
                            ))
                        .toList()),
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
                          onPressed: () {
                            productGridItemData.addToFav();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: productGridItemData.isFav
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            productGridItemData.addToFav();
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
            Flexible(
              child: Text(
                gridItem.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: itemTitleStyle,
                textAlign:
                    currentLang == 'ar' ? TextAlign.right : TextAlign.left,
              ),
            ),

            ///price
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      gridItem.regularPrice! + currency,
                      style: gridItem.onSale != null && gridItem.onSale == true
                          ? itemPriceStyle.copyWith(
                              decoration: TextDecoration.lineThrough)
                          : itemPriceStyle,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    gridItem.onSale == true
                        ? Text(
                            gridItem.salePrice! + currency,
                            style: itemPriceStyle.copyWith(
                                color: const Color(0xffc91f1f)),
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
  }
}

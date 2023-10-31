import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_variation.dart';
import '../ui/cart/cart_view_model.dart';
import '../utilities/general.dart';

class CartCard extends StatelessWidget {
  final Product product;
  final CartItem cartItem;
  const CartCard({Key? key, required this.product, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    var currency = General.getCurrency(context);
    ProductVariation? selectedVariation = cartItem.productDetails;

    var nameStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 12,
      letterSpacing: 2.2,
    );

    var priceStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 2.8,
    );
    print("product in cart card" + product.toJson());
    print("cartitem in cart card" + cartItem.toJson());

    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          ///image
          Container(
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      selectedVariation != null
                          ? selectedVariation.image?.src ?? ''
                          : product.images?.first.src ?? '',
                    ),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///name
                  Expanded(
                    child: Text(
                      product.name ?? "",
                      maxLines: 2,
                      style: nameStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  product.type == 'variable'
                      ?

                      /// attributes
                      selectedVariation != null
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: selectedVariation.attributes!
                                    .map((e) => Row(
                                          children: [
                                            Text(
                                              '${e.name} : ',
                                              style: nameStyle.copyWith(
                                                  color:
                                                      const Color(0xff97969a)),
                                            ),
                                            Text(
                                              e.option ?? '',
                                              style: nameStyle.copyWith(
                                                  color:
                                                      const Color(0xff97969a)),
                                            )
                                          ],
                                        ))
                                    .toList(),
                              ),
                            )
                          : Container()
                      : Container(),

                  ///price & cart controller
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///price
                      product.type == 'variable'
                          ?

                          ///variable
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                selectedVariation != null &&
                                        selectedVariation.price!.isNotEmpty

                                    ///variation has price --> view it
                                    ? Text(
                                        "${General().selectedCurrencyPrice(price: selectedVariation.price ?? '1.0', rate: currency.rate ?? 1.0).toStringAsFixed(2)} ${currency.symbol}",
                                        style: selectedVariation.onSale == true
                                            ? priceStyle.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough)
                                            : priceStyle,
                                      )

                                    ///variation has no price --> view product price
                                    : Text(
                                        "${General().selectedCurrencyPrice(price: product.regularPrice ?? '1.0', rate: currency.rate ?? 1.0).toStringAsFixed(2)} ${currency.symbol}",
                                        style: priceStyle),

                                /// if on sale
                                selectedVariation != null &&
                                        // cartData.selectedVariation!.onSale != null &&
                                        selectedVariation.onSale == true
                                    ? Text(
                                        "${General().selectedCurrencyPrice(price: selectedVariation.salePrice ?? '1.0', rate: currency.rate ?? 1.0).toStringAsFixed(2)} ${currency.symbol}",
                                        style: priceStyle.copyWith(
                                            color: const Color(0xffc91f1f)),
                                      )
                                    : Container()
                              ],
                            )
                          :

                          ///not variable
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${General().selectedCurrencyPrice(price: product.regularPrice ?? '0.0', rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}",
                                  style: product.onSale == true
                                      ? priceStyle.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : priceStyle,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),

                                /// if on sale

                                product.onSale != null && product.onSale == true
                                    ? Text(
                                        currency.country?.toLowerCase() ==
                                                "india"
                                            ? "${currency.symbol} ${General().selectedCurrencyPrice(price: product.salePrice ?? '0.0', rate: currency.rate!).toStringAsFixed(2)}"
                                            : "${General().selectedCurrencyPrice(price: product.salePrice ?? '0.0', rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}",
                                        style: priceStyle.copyWith(
                                            color: const Color(0xffc91f1f)),
                                      )
                                    : Container()
                              ],
                            ),

                      ///cart controller
                      Consumer<CartViewModel>(builder: (context, viewModel, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  viewModel.decrement(
                                      product, cartItem, context);
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xffe5e5eb),
                                  shape: const CircleBorder(),
                                )),
                            Text(
                              '${cartItem.quantity}',
                              style: nameStyle.copyWith(fontSize: 12),
                            ),
                            TextButton(
                                onPressed: () {
                                  viewModel.increment(
                                      product, cartItem, context);
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: const CircleBorder(),
                                )),
                          ],
                        );
                      })
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

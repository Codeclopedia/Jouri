import 'package:Jouri/components/cart_card/cart_card_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartCardViewModel>(context, listen: false);

    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var currency = currentLang == 'ar' ? ' د.ك' : ' DK';

    var nameStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 2.2,
    );

    var priceStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 2.8,
    );

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
                      cartData.cartItem.productDetails != null
                          ? cartData.cartItem.productDetails!.image!.src!
                          : cartData.product.images!.first.src!,
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///name
                Flexible(
                    child: Text(
                  cartData.product.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: nameStyle,
                )),
                const SizedBox(
                  height: 10,
                ),
                cartData.product.type == 'variable'
                    ?

                    /// attributes
                    cartData.selectedVariation != null
                        ? Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: cartData.selectedVariation!.attributes!
                                  .map((e) => Row(
                                        children: [
                                          Text(
                                            e.name! + ' : ',
                                            style: nameStyle.copyWith(
                                                color: const Color(0xff97969a)),
                                          ),
                                          Text(
                                            e.option!,
                                            style: nameStyle.copyWith(
                                                color: const Color(0xff97969a)),
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
                  children: [
                    ///price
                    cartData.product.type == 'variable'
                        ?

                        ///variable
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              cartData.selectedVariation != null &&
                                      cartData.selectedVariation!.price != ''

                                  ///variation has price --> view it
                                  ? Text(
                                      cartData.selectedVariation!
                                              .regularPrice! +
                                          currency,
                                      style: cartData
                                                  .selectedVariation!.onSale ==
                                              true
                                          ? priceStyle.copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough)
                                          : priceStyle,
                                    )

                                  ///variation has no price --> view product price
                                  : Text(
                                      cartData.product.regularPrice! + currency,
                                      style: priceStyle),
                              const SizedBox(
                                width: 15,
                              ),

                              /// if on sale

                              cartData.selectedVariation != null &&
                                      // cartData.selectedVariation!.onSale != null &&
                                      cartData.selectedVariation!.onSale == true
                                  ? Text(
                                      cartData.selectedVariation!.salePrice! +
                                          currency,
                                      style: priceStyle.copyWith(
                                          color: const Color(0xffc91f1f)),
                                    )
                                  : Container()
                            ],
                          )
                        :

                        ///not variable
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(cartData.product.regularPrice! + currency,
                                  style: priceStyle),
                              const SizedBox(
                                width: 15,
                              ),

                              /// if on sale

                              cartData.product.onSale != null &&
                                      cartData.product.onSale == true
                                  ? Text(
                                      cartData.product.salePrice! + currency,
                                      style: priceStyle.copyWith(
                                          color: const Color(0xffc91f1f)),
                                    )
                                  : Container()
                            ],
                          ),

                    ///cart controller
                    Consumer<CartCardViewModel>(
                        builder: (context, viewModel, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                viewModel.decrement();
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 18,
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffe5e5eb),
                                shape: const CircleBorder(),
                              )),
                          Text(
                            '${viewModel.quantity}',
                            style: nameStyle.copyWith(fontSize: 14),
                          ),
                          TextButton(
                              onPressed: () {
                                viewModel.increment();
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: const CircleBorder(),
                              )),
                        ],
                      );
                    })
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

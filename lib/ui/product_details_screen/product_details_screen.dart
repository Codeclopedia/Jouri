import 'package:Jouri/models/currency_data_response.dart';
import 'package:Jouri/ui/app_bar/app_bar.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:Jouri/ui/product_details_screen/product_details_view_model.dart';
import 'package:Jouri/utilities/general.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../components/loading.dart';
import '../../components/product_card/product_card.dart';
import '../../components/product_card/product_card_view_model.dart';
import '../../models/attribute_term.dart';
import '../../models/product.dart';
import '../../models/product_variation.dart';
import '../app_bar/app_bar_view_model.dart';
import '../cart/cart_view_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productDetailsData =
        Provider.of<ProductDetailsViewModel>(context, listen: false);

    var currentLang = General.getLanguage(context);
    var currency =
        Provider.of<NavMenuViewModel>(context, listen: false).selectedCurrency;

    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 16,
      letterSpacing: 2,
    );

    var priceStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: Theme.of(context).primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 4.2,
    );
    print("product detail ${productDetailsData.isVariable}");
    print("selected currency data in page is ${currency.toJson()}");
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(0xfff8f9ff),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///app bar
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

              ///body
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productDetailsData.isVariable

                            /// is variable --> will view the details of the selected variation
                            ? FutureBuilder<List<ProductVariation>>(
                                future: productDetailsData.loadVariations(
                                    context, currentLang),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ///image
                                        Consumer<ProductDetailsViewModel>(
                                            builder: (context, viewModel, _) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: productDetailsData
                                                        .selectedVariation !=
                                                    null

                                                ///selected variation is not null --> view image / placeholder
                                                ? productDetailsData
                                                            .selectedVariation!
                                                            .image !=
                                                        null

                                                    ///image of selected variation is not null
                                                    ? CachedNetworkImage(
                                                        imageUrl: viewModel
                                                            .selectedVariation!
                                                            .image!
                                                            .src!,
                                                        fit: BoxFit.cover,
                                                        height: 400,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      )

                                                    ///image of selected variation is null
                                                    : Image.asset(
                                                        'assets/images/hijab_placeholder.jpg',
                                                        height: 400,
                                                        fit: BoxFit.cover,
                                                      )

                                                ///selected variation is null
                                                : Image.asset(
                                                    'assets/images/hijab_placeholder.jpg',
                                                    height: 400,
                                                    fit: BoxFit.cover,
                                                  ),
                                          );
                                        }),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        ///details
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ///fav
                                              Consumer<ProductDetailsViewModel>(
                                                  builder:
                                                      (context, viewModel, _) {
                                                return IconButton(
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: viewModel.isFav
                                                        ? Colors.red
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    if (!viewModel.isFav) {
                                                      viewModel
                                                          .addToFav(context);
                                                    } else {
                                                      viewModel.removeFromFav();
                                                    }
                                                  },
                                                );
                                              }),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              ///name
                                              Text(
                                                productDetailsData
                                                    .product.name!,
                                                style: titleStyle,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),

                                              ///price & cart controller
                                              Consumer<ProductDetailsViewModel>(
                                                  builder:
                                                      (context, viewModel, _) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 1.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          viewModel
                                                                      .selectedVariation
                                                                      ?.price
                                                                      ?.isNotEmpty ??
                                                                  false ||
                                                                      viewModel
                                                                              .selectedVariation
                                                                              ?.price !=
                                                                          ''

                                                              ///variation has price --> view it
                                                              ? Text(
                                                                  "${General().selectedCurrencyPrice(price: viewModel.selectedVariation?.price ?? '0.0', rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}",
                                                                  style: viewModel.selectedVariation?.onSale != null &&
                                                                          viewModel.selectedVariation?.onSale ==
                                                                              true
                                                                      ? priceStyle.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          decoration: TextDecoration
                                                                              .lineThrough)
                                                                      : priceStyle.copyWith(
                                                                          fontSize:
                                                                              15),
                                                                )

                                                              ///variation has no price --> view product price
                                                              : Text(
                                                                  "${General().selectedCurrencyPrice(price: viewModel.product.regularPrice ?? '1.0', rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}",
                                                                  style: priceStyle
                                                                      .copyWith(
                                                                          fontSize:
                                                                              15),
                                                                ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          viewModel.selectedVariation
                                                                      ?.onSale ==
                                                                  true
                                                              ? Text(
                                                                  ' ${General().selectedCurrencyPrice(price: viewModel.selectedVariation?.salePrice ?? '1.0', rate: currency.rate!).toStringAsFixed(2)} ${currency.symbol}',
                                                                  style: priceStyle.copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color: const Color(
                                                                          0xffc91f1f)),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),

                                                    ///cart controller
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              productDetailsData
                                                                  .decrement();
                                                            },
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffe5e5eb),
                                                              shape:
                                                                  const CircleBorder(),
                                                            )),
                                                        Text(
                                                          '${productDetailsData.quantity}',
                                                          style: titleStyle
                                                              .copyWith(
                                                                  fontSize: 14),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              productDetailsData
                                                                  .increment();
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              shape:
                                                                  const CircleBorder(),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              }),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Divider(
                                                  color: Color(0xfff8f9ff),
                                                  thickness: 2,
                                                ),
                                              ),

                                              ///colors
                                              _buildColors(
                                                  context,
                                                  productDetailsData,
                                                  currentLang),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Divider(
                                                  color: Color(0xfff8f9ff),
                                                  thickness: 2,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          showTopSnackBar(
                                                            Overlay.of(
                                                                context)!,
                                                            CustomSnackBar
                                                                .success(
                                                              message:
                                                                  "Item Successfully Added to your cart.",
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffEC297B),
                                                            ),
                                                          );

                                                          productDetailsData
                                                              .addToCart(
                                                                  context);
                                                        },
                                                        child: const LocalizedText(
                                                            'productDetailsPage.addToCart')),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return const Center(child: Loading());
                                  }
                                },
                              )

                            /// not variable --> will view the details of the product itself
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    ///image
                                    productDetailsData
                                            .product.images!.isNotEmpty
                                        ? ImageSlideshow(
                                            width: double.infinity,
                                            isLoop: true,
                                            initialPage: 0,
                                            indicatorColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            autoPlayInterval: 4000,
                                            children: productDetailsData
                                                .product.images!
                                                .map((item) => ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: item.src!,
                                                        fit: BoxFit.cover,
                                                        height: 400,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ) /* Image.network(
                                                        item.src!,
                                                        height: 400,
                                                        fit: BoxFit.cover,
                                                      ) */
                                                      ,
                                                    ))
                                                .toList(),
                                          )
                                        : Image.asset(
                                            'assets/images/hijab_placeholder.jpg',
                                            height: 400,
                                            fit: BoxFit.cover,
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),

                                    ///details
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ///fav
                                          Consumer<ProductDetailsViewModel>(
                                              builder: (context, viewModel, _) {
                                            return IconButton(
                                              icon: Icon(
                                                Icons.favorite,
                                                color: viewModel.isFav
                                                    ? Colors.red
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                              onPressed: () {
                                                if (!viewModel.isFav) {
                                                  viewModel.addToFav(context);
                                                } else {
                                                  viewModel.removeFromFav();
                                                }
                                              },
                                            );
                                          }),
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          ///name
                                          Text(
                                            productDetailsData.product.name!,
                                            style: titleStyle,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),

                                          ///price & cart controller
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        General()
                                                                .selectedCurrencyPrice(
                                                                    price: productDetailsData
                                                                        .product
                                                                        .regularPrice,
                                                                    rate: currency
                                                                            .rate ??
                                                                        1.0)
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString() +
                                                            currency.symbol!,
                                                        style: productDetailsData
                                                                        .product
                                                                        .onSale !=
                                                                    null &&
                                                                productDetailsData
                                                                        .product
                                                                        .onSale ==
                                                                    true
                                                            ? priceStyle.copyWith(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough)
                                                            : priceStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        15)),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    productDetailsData.product
                                                                .onSale ==
                                                            true
                                                        ? Text(
                                                            productDetailsData
                                                                    .product
                                                                    .salePrice! +
                                                                currency
                                                                    .symbol!,
                                                            style: priceStyle.copyWith(
                                                                color: const Color(
                                                                    0xffc91f1f)),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),

                                              ///cart controller
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          _buildColors(context,
                                              productDetailsData, currentLang),
                                          Consumer<ProductDetailsViewModel>(
                                              builder: (context, viewModel, _) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      productDetailsData
                                                          .decrement();
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffe5e5eb),
                                                      shape:
                                                          const CircleBorder(),
                                                    )),
                                                Text(
                                                  '${productDetailsData.quantity}',
                                                  style: titleStyle.copyWith(
                                                      fontSize: 14),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      productDetailsData
                                                          .increment();
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      shape:
                                                          const CircleBorder(),
                                                    )),
                                              ],
                                            );
                                          }),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      showTopSnackBar(
                                                        Overlay.of(context)!,
                                                        CustomSnackBar.success(
                                                          message:
                                                              "Item Successfully Added to your cart.",
                                                          backgroundColor:
                                                              const Color(
                                                                  0xffEC297B),
                                                        ),
                                                      );

                                                      productDetailsData
                                                          .addToCart(context);
                                                    },
                                                    child: const LocalizedText(
                                                        'productDetailsPage.addToCart')),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),

                        ///add to cart

                        const SizedBox(
                          height: 20,
                        ),

                        ///description
                        productDetailsData.product.description != ""
                            ? Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xfff8f9ff),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Html(
                                  data: productDetailsData.product.description!,
                                ))
                            : Container(),

                        ///attributes
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                productDetailsData.product.attributes!.length,
                            itemBuilder: (context, index) {
                              print(
                                  'product data ${productDetailsData.product.attributes![index].toJson()}');
                              return Column(
                                children: [
                                  ExpansionTile(
                                    title: Text(
                                      productDetailsData
                                          .product.attributes![index].name!,
                                      style: titleStyle.copyWith(
                                          letterSpacing: 2.8, fontSize: 14),
                                    ),
                                    trailing: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    collapsedIconColor:
                                        Theme.of(context).primaryColor,
                                    iconColor:
                                        Theme.of(context).colorScheme.secondary,
                                    textColor:
                                        Theme.of(context).colorScheme.secondary,
                                    collapsedTextColor:
                                        Theme.of(context).primaryColor,
                                    childrenPadding: const EdgeInsets.all(15),
                                    children: productDetailsData
                                        .product.attributes![index].options!
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      size: 15,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        e,
                                                        style:
                                                            titleStyle.copyWith(
                                                          fontSize: 11,
                                                          letterSpacing: 2.8,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ))
                                        .toList(),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Divider(
                                      color: Color(0xfff8f9ff),
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              );
                            }),

                        const SizedBox(
                          height: 30,
                        ),

                        ///related products
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: LocalizedText(
                            'productDetailsPage.relatedProducts',
                            style: titleStyle.copyWith(
                                fontSize: 14, letterSpacing: 2.8),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        productDetailsData.loadedRelatedProducts.isEmpty
                            ? FutureBuilder<List<Product>>(
                                future: productDetailsData.loadRelatedProducts(
                                    context, currentLang),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height: 320,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: ChangeNotifierProvider(
                                                create: (context) =>
                                                    ProductCardViewModel(
                                                        product: snapshot
                                                            .data![index]),
                                                child: ProductCard(
                                                  gridItem:
                                                      snapshot.data![index],
                                                  currentLang: currentLang,
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  } else {
                                    return const Center(
                                      child: Loading(),
                                    );
                                  }
                                })
                            : Container(
                                height: 320,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: productDetailsData
                                        .loadedRelatedProducts.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: ChangeNotifierProvider(
                                          create: (context) =>
                                              ProductCardViewModel(
                                                  product: productDetailsData
                                                          .loadedRelatedProducts[
                                                      index]),
                                          child: ProductCard(
                                            gridItem: productDetailsData
                                                .loadedRelatedProducts[index],
                                            currentLang: currentLang,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildColors(BuildContext context, ProductDetailsViewModel productDetailsData,
      String currentLang) {
    return FutureBuilder<List<AttributeTerm>>(
      future: productDetailsData.loadColorAttributeTerms(context, currentLang),
      builder: (context, snapshot) {
        return Consumer<ProductDetailsViewModel>(
          builder: (context, viewModel, _) {
            return Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productDetailsData.usedColorAttributeTerms.length,
                itemBuilder: (context, index) {
                  // print(
                  //     'color in circles ${productDetailsData.usedColorAttributeTerms}');
                  productDetailsData.hexToColor(
                      productDetailsData.usedColorAttributeTerms[index]);
                  return InkWell(
                    onTap: () {
                      productDetailsData.changeVariation(
                          productDetailsData.usedColorAttributeTerms[index],
                          index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: currentLang == 'ar' ? 10.0 : 0.0,
                          right: currentLang == 'ar' ? 0.0 : 10.0),
                      height: index == productDetailsData.selectedColorIndex
                          ? 30
                          : 25,
                      width: index == productDetailsData.selectedColorIndex
                          ? 30
                          : 25,
                      decoration: BoxDecoration(
                        color: Color(productDetailsData.color),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                index == productDetailsData.selectedColorIndex
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.black12,
                            width: 1),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

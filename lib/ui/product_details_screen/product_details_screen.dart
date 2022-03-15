import 'package:Jouri/ui/product_details_screen/product_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';
import '../../components/loading.dart';
import '../../components/product_card/product_card.dart';
import '../../components/product_card/product_card_view_model.dart';
import '../../models/attribute_term.dart';
import '../../models/product.dart';
import '../../models/product_variation.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productDetailsData =
        Provider.of<ProductDetailsViewModel>(context, listen: false);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var currency = currentLang == 'ar' ? 'د.ك' : 'DK';

    var titleStyle = const TextStyle(
      color: Color(0xff000000),
      fontSize: 14,
      fontStyle: FontStyle.normal,
      letterSpacing: 3.2,
    );

    var priceStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 4.2,
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
      body: Container(
        color: const Color(0xfff8f9ff),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<ProductVariation>>(
                future: productDetailsData.loadVariations(context, currentLang),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///image
                        Consumer<ProductDetailsViewModel>(
                            builder: (context, viewModel, _) {
                          return Container(
                            child: productDetailsData.selectedVariation != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      viewModel.selectedVariation!.image!.src!,
                                      height: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ImageSlideshow(
                                    width: double.infinity,
                                    isLoop: true,
                                    initialPage: 0,
                                    indicatorColor:
                                        Theme.of(context).colorScheme.secondary,
                                    autoPlayInterval: 4000,
                                    children: viewModel.product.images!
                                        .map((item) => ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                item.src!,
                                                height: 400,
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        .toList(),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///fav
                              Consumer<ProductDetailsViewModel>(
                                  builder: (context, viewModel, _) {
                                return IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: viewModel.isFav
                                        ? Colors.red
                                        : Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    viewModel.addToFav();
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
                                children: [
                                  Consumer<ProductDetailsViewModel>(
                                      builder: (context, viewModel, _) {
                                    return Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              viewModel.selectedVariation!
                                                      .regularPrice! +
                                                  currency,
                                              style: viewModel.selectedVariation!
                                                              .onSale !=
                                                          null &&
                                                      viewModel
                                                              .selectedVariation!
                                                              .onSale ==
                                                          true
                                                  ? priceStyle.copyWith(
                                                      decoration: TextDecoration
                                                          .lineThrough)
                                                  : priceStyle,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            viewModel.selectedVariation!
                                                        .onSale ==
                                                    true
                                                ? Text(
                                                    viewModel.selectedVariation!
                                                            .salePrice! +
                                                        currency,
                                                    style: priceStyle.copyWith(
                                                        color: const Color(
                                                            0xffc91f1f)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(
                                  color: Color(0xfff8f9ff),
                                  thickness: 2,
                                ),
                              ),

                              ///colors
                              FutureBuilder<List<AttributeTerm>>(
                                  future: productDetailsData
                                      .loadColorAttributeTerms(
                                          context, currentLang),
                                  builder: (context, snapshot) {
                                    return Consumer<ProductDetailsViewModel>(
                                        builder: (context, viewModel, _) {
                                      return Container(
                                        height: 70,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: productDetailsData
                                                .usedColorAttributeTerms.length,
                                            itemBuilder: (context, index) {
                                              productDetailsData.hexToColor(
                                                  productDetailsData
                                                          .usedColorAttributeTerms[
                                                      index]);
                                              return InkWell(
                                                onTap: () {
                                                  productDetailsData
                                                      .changeVariation(
                                                          productDetailsData
                                                                  .usedColorAttributeTerms[
                                                              index],
                                                          index);
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            currentLang == 'ar'
                                                                ? 10.0
                                                                : 0.0,
                                                        right:
                                                            currentLang == 'ar'
                                                                ? 0.0
                                                                : 10.0),
                                                    height: index ==
                                                            productDetailsData
                                                                .selectedColorIndex
                                                        ? 30
                                                        : 25,
                                                    width: index ==
                                                            productDetailsData
                                                                .selectedColorIndex
                                                        ? 30
                                                        : 25,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          productDetailsData
                                                              .color),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: index ==
                                                                  productDetailsData
                                                                      .selectedColorIndex
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary
                                                              : Colors.black12,
                                                          width: 1),
                                                    )),
                                              );
                                            }),
                                      );
                                    });
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Divider(
                                  color: Color(0xfff8f9ff),
                                  thickness: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              ///add to cart
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: const LocalizedText(
                                            'productDetails.addToCart')),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
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
                                        data: productDetailsData
                                            .product.description!,
                                      ))
                                  : Container(),

                              ///attributes
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: productDetailsData
                                      .product.attributes!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text(
                                            productDetailsData.product
                                                .attributes![index].name!,
                                            style: titleStyle.copyWith(
                                              letterSpacing: 2.8,
                                            ),
                                          ),
                                          trailing: const Icon(
                                            Icons.add,
                                            size: 20,
                                          ),
                                          collapsedIconColor:
                                              Theme.of(context).primaryColor,
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          textColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          collapsedTextColor:
                                              Theme.of(context).primaryColor,
                                          childrenPadding:
                                              const EdgeInsets.all(15),
                                          children: productDetailsData.product
                                              .attributes![index].options!
                                              .map((e) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        size: 15,
                                                      ),
                                                      Text(
                                                        e,
                                                        style:
                                                            titleStyle.copyWith(
                                                          fontSize: 11,
                                                          letterSpacing: 2.8,
                                                        ),
                                                      ),
                                                    ]),
                                                  ))
                                              .toList(),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Divider(
                                            color: Color(0xfff8f9ff),
                                            thickness: 2,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),

                              ///related products
                              productDetailsData.loadedRelatedProducts.isEmpty
                                  ? FutureBuilder<List<Product>>(
                                      future: productDetailsData
                                          .loadRelatedProducts(
                                              context, currentLang),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            height: 250,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0),
                                                    child:
                                                        ChangeNotifierProvider(
                                                      create: (context) =>
                                                          ProductCardViewModel(
                                                              product: snapshot
                                                                      .data![
                                                                  index]),
                                                      child: ProductCard(
                                                        gridItem: snapshot
                                                            .data![index],
                                                        currentLang:
                                                            currentLang,
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
                                      height: 250,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: productDetailsData
                                              .loadedRelatedProducts.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: ChangeNotifierProvider(
                                                create: (context) =>
                                                    ProductCardViewModel(
                                                        product: productDetailsData
                                                                .loadedRelatedProducts[
                                                            index]),
                                                child: ProductCard(
                                                  gridItem: productDetailsData
                                                          .loadedRelatedProducts[
                                                      index],
                                                  currentLang: currentLang,
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Center(child: Loading());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

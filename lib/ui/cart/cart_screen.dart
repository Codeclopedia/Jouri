import 'package:Jouri/ui/cart/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/cart_card.dart';
import '../../components/loading.dart';
import '../../models/product.dart';
import '../../utilities/general.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/app_bar_view_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartViewModel>(context);
    final GlobalKey<AnimatedListState> _listKey = GlobalKey();
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var currency = currentLang == 'ar' ? ' د.ك' : ' DK';

    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 21,
      fontWeight: FontWeight.w500,
      letterSpacing: 4.2,
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///app bar
              // ChangeNotifierProvider(
              //     create: (context) => AppBarViewModel(withCartButton: false),
              //     child: const AppBarSection()),
              MultiProvider(providers: [
                ChangeNotifierProvider(
                  create: (context) => AppBarViewModel(withCartButton: false),
                ),
                ChangeNotifierProvider(
                  create: (context) => CartViewModel(),
                ),
              ], child: const AppBarSection()),

              ///body
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  LocalizedText(
                    'cartPage.shoppingCart',
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  General.getCartCount() == 0
                      ? Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocalizedText(
                                'cartPage.emptyCart',
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
                              // Container(
                              //   height: 100,
                              //   decoration: const BoxDecoration(
                              //       image: DecorationImage(
                              //           image: AssetImage(
                              //               'assets/images/empty_cart.png',))),
                              // ),
                              Image.asset('assets/images/empty_cart.png',
                                  height: 100,
                                  color:
                                      Theme.of(context).colorScheme.secondary)
                            ],
                          ),
                        )
                      : FutureBuilder<List<Product>>(
                          future: cartData.loadCart(context),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            key: _listKey,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var item = General.getSpecificCart(
                                                  productId: int.parse(
                                                      // snapshot.data![index].translations.ar ??
                                                      '${snapshot.data![index].id}'));
                                              item ??= General.getSpecificCart(
                                                  productId: int.parse(
                                                      // snapshot.data![index].translations.en ??
                                                      '${snapshot.data![index].id}'));
                                              return Column(
                                                children: [
                                                  const Divider(
                                                      color: Color(0xffe7ebf5)),
                                                  CartCard(
                                                    product:
                                                        snapshot.data![index],
                                                    cartItem: item!,
                                                    // recalculatePrice: _changePrice,
                                                    // removeProductFromCart: _removeCartItem,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    LocalizedText(
                                      'cartPage.orderSummery',
                                      style: titleStyle,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ListTile(
                                      title: Text(
                                        General.getTranslatedText(
                                            context, 'cartPage.orderSubtotal'),
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      leading: Icon(
                                        Icons.monetization_on,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      trailing: Text(
                                        cartData.calculatePrice() + currency,
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Navigator.of(context).push(CupertinoPageRoute(builder: (_)=>ShippingMethodsScreen()));
                                            },
                                            child: const LocalizedText(
                                                'cartPage.proceed'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return const Center(child: Loading());
                            }
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:Jouri/models/customer.dart';
import 'package:Jouri/ui/cart/cart_view_model.dart';
import 'package:Jouri/ui/checkout/checkout.dart';
import 'package:Jouri/ui/checkout/checkout_view_model.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/cart_card.dart';
import '../../components/loading.dart';
import '../../models/checkout_models/shipping_zone_location.dart';
import '../../models/product.dart';
import '../../utilities/general.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/app_bar_view_model.dart';
import '../auth/login/login_screen.dart';
import '../auth/login/login_view_model.dart';
import '../checkout/new_checkout_design.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartViewModel>(context);
    final GlobalKey<AnimatedListState> _listKey = GlobalKey();
    var currentLang = General.getLanguage(context);
    var currency = General.getCurrency(context);

    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 22,
      letterSpacing: 4.2,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff8f9ff),
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
                          height: 400,
                          child: Lottie.asset(
                            'assets/lottie/empty_cart.json',
                            repeat: false,
                            alignment: Alignment.center,
                            width: 200,
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
                                            itemCount:
                                                cartData.cartProducts.length,
                                            key: _listKey,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var item = General.getSpecificCart(
                                                  productId: int.parse(
                                                      // snapshot.data![index].translations.ar ??
                                                      '${cartData.cartProducts[index].id}'));

                                              item ??= General.getSpecificCart(
                                                  productId: int.parse(
                                                      // snapshot.data![index].translations.en ??
                                                      '${cartData.cartProducts[index].id}'));

                                              return Column(
                                                children: [
                                                  const Divider(
                                                      color: Color(0xffe7ebf5)),
                                                  CartCard(
                                                    product:
                                                        snapshot.data![index],
                                                    cartItem: item!,
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
                                    Divider(),
                                    const SizedBox(
                                      height: 6,
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
                                        size: 30,
                                      ),
                                      trailing: Text(
                                        cartData.calculatePrice(context) +
                                            " " +
                                            currency.symbol!,
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                      "* The current total doesn't include any shipping charges. Required fee and charges will be added later .",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (cartData
                                                  .cartProducts.isNotEmpty) {
                                                EasyLoading.show();
                                                await Provider.of<
                                                            CheckoutViewModel>(
                                                        context,
                                                        listen: false)
                                                    .loadAllShippingZoneLocations(
                                                        context);
                                                EasyLoading.dismiss();
                                                var user =
                                                    await General.getUser();
                                                if (user == null) {
                                                  showGuestDialog(
                                                      context,
                                                      context
                                                          .read<
                                                              CheckoutViewModel>()
                                                          .countryCodeList);
                                                } else {
                                                  var customer =
                                                      Customer.fromJson(user);

                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  MultiProvider(
                                                                    providers: [
                                                                      ChangeNotifierProvider(
                                                                          create: (context) =>
                                                                              CartViewModel()),
                                                                    ],
                                                                    child: CheckoutDetailsPage(
                                                                        customer:
                                                                            customer,
                                                                        countryCodeList: context
                                                                            .read<CheckoutViewModel>()
                                                                            .countryCodeList),
                                                                  )));
                                                }
                                              }
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

  void showGuestDialog(
      BuildContext context, List<ShippingZoneLocation> countryCodeList) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Image.asset(
            'assets/images/logo.png',
            height: 100,
          ),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                General.getTranslatedText(context, 'cartPage.notLoggedIn'),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 230,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                              create: (context) => LoginViewModel(),
                              child: const LoginScreen(),
                            )));
                  },
                  child: Text(
                    General.getTranslatedText(context, 'navMenu.login'),
                  ),
                ),
              ),
              Container(
                width: 230,
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                      create: (context) => CartViewModel(),
                                    ),
                                  ],
                                  child: CheckoutDetailsPage(
                                    countryCodeList: countryCodeList,
                                  ),
                                )));
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                  ),
                  child: Text(
                    General.getTranslatedText(
                        context, 'cartPage.proceedAsGuest'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

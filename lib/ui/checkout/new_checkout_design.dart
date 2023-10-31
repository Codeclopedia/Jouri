import 'dart:convert';

import 'package:Jouri/components/loading.dart';
import 'package:Jouri/models/checkout_models/shipping_zone.dart';
import 'package:Jouri/models/checkout_models/shipping_zone_location.dart';
import 'package:Jouri/models/checkout_models/user_detail_model.dart';
import 'package:Jouri/ui/checkout/widgets/custom_textformfeild.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/utils.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/customer.dart';
import '../../models/product.dart';
import '../../utilities/general.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/app_bar_view_model.dart';
import '../cart/cart_view_model.dart';
import 'checkout_view_model.dart';

class CheckoutDetailsPage extends StatelessWidget {
  final Customer? customer;
  final List<ShippingZoneLocation> countryCodeList;
  CheckoutDetailsPage({Key? key, this.customer, required this.countryCodeList})
      : super(key: key);

  late CheckoutViewModel viewModel;

  TextStyle headingTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.06,
        fontWeight: FontWeight.w600);
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CheckoutViewModel>(context, listen: false);
    viewModel.fillData(customer);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          viewModel.changeSelectedDetailTab(0);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              MultiProvider(providers: [
                ChangeNotifierProvider(
                  create: (context) => AppBarViewModel(withCartButton: false),
                ),
                ChangeNotifierProvider(
                  create: (context) => CartViewModel(),
                ),
              ], child: AppBarSection()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              orderProcessStep(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              orderBody(context),
            ],
          ),
        ),
      ),
    );
  }

  orderProcessStep(BuildContext context) {
    return Container(
        color: Colors.blueGrey.withOpacity(0.1),
        alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            itemTile(
                'package.png',
                'Detail',
                context.watch<CheckoutViewModel>().selectedOrderDetailTab >= 0
                    ? true
                    : false,
                context,
                true),
            itemTile(
                'credit-cards.png',
                'Payment',
                context.watch<CheckoutViewModel>().selectedOrderDetailTab >= 1
                    ? true
                    : false,
                context,
                false),
            itemTile(
                'review.png',
                'Review',
                context.watch<CheckoutViewModel>().selectedOrderDetailTab >= 2
                    ? true
                    : false,
                context,
                false),
          ],
        ));
  }

  Widget orderBody(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child:
                  context.watch<CheckoutViewModel>().selectedOrderDetailTab == 2
                      ? orderCompleteBody(context)
                      : context
                                  .watch<CheckoutViewModel>()
                                  .selectedOrderDetailTab ==
                              1
                          ? paymentPageBody(context)
                          : _buildDataForm(
                              context, viewModel.shippingZoneLocations))),
    );
  }

  paymentPageBody(
    BuildContext context,
  ) {
    final cartData = Provider.of<CartViewModel>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment",
              style: headingTextStyle(context),
            ),
            Divider(),
            Text("Details"),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.01)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${viewModel.firstnameController.text} ${viewModel.lastnameController.text}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${viewModel.addressController.text}, ${viewModel.cityController.text}, ${viewModel.countryController.text}"),
                    Text(
                        "${viewModel.dialcodes} ${viewModel.mobileController.text}"),
                    Text("${viewModel.emailController.text}")
                  ],
                ),
              ),
            ),
            Divider(),
            Text(
              "Bill Details",
              style: headingTextStyle(context),
            ),
            FutureBuilder<List<Product>>(
              future: cartData.loadCart(context),
              builder: (context, snapshot) {
                double totalcost = 0;
                if (snapshot.hasData && snapshot.data != null) {
                  final cartProducts =
                      Provider.of<CartViewModel>(context).cartProducts;

                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.01)),
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02,
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartData.cartProducts.length,
                          itemBuilder: (context, index) {
                            final product = cartData.cartProducts[index];
                            var item =
                                General.getSpecificCart(productId: int.parse(
                                    // snapshot.data![index].translations.ar ??
                                    '${cartData.cartProducts[index].id}'));

                            item ??=
                                General.getSpecificCart(productId: int.parse(
                                    // snapshot.data![index].translations.en ??
                                    '${cartData.cartProducts[index].id}'));
                            final shippingCost = viewModel.shippingMethods
                                .firstWhere((element) =>
                                    element.id ==
                                    viewModel.selectedShippingMethod)
                                .settings
                                ?.cost
                                ?.value;

                            totalcost = (product.salePrice?.isEmpty ?? false
                                    ? double.parse(product.price ?? "1.0") +
                                        totalcost
                                    : double.parse(product.salePrice ?? "1.0") +
                                        totalcost) *
                                item!.quantity;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.002),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${product.name ?? ""} x ${item.quantity}"),
                                  Row(
                                    textDirection:
                                        Provider.of<NavMenuViewModel>(context)
                                                    .selectedCurrency
                                                    .country
                                                    ?.toLowerCase() ==
                                                "india"
                                            ? TextDirection.ltr
                                            : TextDirection.rtl,
                                    children: [
                                      Text(
                                          Provider.of<NavMenuViewModel>(context)
                                              .selectedCurrency
                                              .symbol!),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      Text((double.parse(item.quantity.toString()) *
                                              double.parse(product
                                                          .salePrice?.isEmpty ??
                                                      false
                                                  ? General()
                                                      .selectedCurrencyPrice(
                                                          price: product.price,
                                                          rate: Provider.of<NavMenuViewModel>(context)
                                                                  .selectedCurrency
                                                                  .rate ??
                                                              1.0)
                                                      .toStringAsFixed(2)
                                                  : General()
                                                      .selectedCurrencyPrice(
                                                          price:
                                                              product.salePrice,
                                                          rate: Provider.of<NavMenuViewModel>(context)
                                                                  .selectedCurrency
                                                                  .rate ??
                                                              1.0)
                                                      .toStringAsFixed(2)))
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipping fee"),
                            Row(
                              textDirection:
                                  Provider.of<NavMenuViewModel>(context)
                                              .selectedCurrency
                                              .country
                                              ?.toLowerCase() ==
                                          "india"
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                              children: [
                                Text(Provider.of<NavMenuViewModel>(context)
                                        .selectedCurrency
                                        .symbol ??
                                    ""),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(General()
                                    .selectedCurrencyPrice(
                                        price: viewModel.shippingMethods
                                            .firstWhere((element) =>
                                                element.id ==
                                                viewModel
                                                    .selectedShippingMethod)
                                            .settings
                                            ?.cost
                                            ?.value,
                                        rate: Provider.of<NavMenuViewModel>(
                                                    context)
                                                .selectedCurrency
                                                .rate ??
                                            1.00)
                                    .toStringAsFixed(2)),
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total"),
                            Row(
                              textDirection:
                                  Provider.of<NavMenuViewModel>(context)
                                              .selectedCurrency
                                              .country
                                              ?.toLowerCase() ==
                                          "india"
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                              children: [
                                Text(Provider.of<NavMenuViewModel>(context)
                                        .selectedCurrency
                                        .symbol ??
                                    ""),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(General()
                                    .selectedCurrencyPrice(
                                        price: totalcost.toString(),
                                        rate: Provider.of<NavMenuViewModel>(
                                                    context)
                                                .selectedCurrency
                                                .rate ??
                                            1.00)
                                    .toStringAsFixed(2)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Loading());
                }
              },
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Align(
            alignment: Alignment.centerLeft,
            child: Text("Payment Method", style: headingTextStyle(context))),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        FutureBuilder(
          future: viewModel.loadPaymentMethods(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.02)),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: viewModel.paymentMethods.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.01),
                        color: viewModel.selectedPaymentMethod ==
                                viewModel.paymentMethods[index]
                            ? Colors.black
                            : Colors.white),
                    child: InkWell(
                      onTap: () {
                        viewModel.changePaymentMethod(
                            viewModel.paymentMethods[index]);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Icon(
                                viewModel.paymentMethods[index].methodTitle
                                            ?.toLowerCase() ==
                                        "cash on delivery"
                                    ? Icons.payments
                                    : Icons.credit_card,
                                color: viewModel.selectedPaymentMethod ==
                                        viewModel.paymentMethods[index]
                                    ? Colors.white
                                    : Colors.black,
                              )),
                          Text(
                            viewModel.paymentMethods[index].methodTitle ?? "ß",
                            style: TextStyle(
                                color: viewModel.selectedPaymentMethod ==
                                        viewModel.paymentMethods[index]
                                    ? Colors.white
                                    : Colors.black),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                viewModel.changeSelectedDetailTab(
                    viewModel.selectedOrderDetailTab - 1);
              },
              splashColor: Color.fromARGB(255, 142, 18, 59),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.01)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                if (viewModel.checkOptions(context)) {
                  viewModel.changeSelectedDetailTab(
                      viewModel.selectedOrderDetailTab + 1);
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.01)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ],
    );
  }

  orderCompleteBody(BuildContext context) {
    final cartData = Provider.of<CartViewModel>(context, listen: false);
    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Order Details", style: headingTextStyle(context)),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.01)),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${viewModel.firstnameController.text} ${viewModel.lastnameController.text}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "${viewModel.addressController.text}, ${viewModel.cityController.text}, ${viewModel.countryController.text}"),
                  Text(
                      "${viewModel.dialcodes} ${viewModel.mobileController.text}"),
                  Text("${viewModel.emailController.text}")
                ],
              ),
            ),
          ),
          Text(
            "Items",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold),
          ),
          FutureBuilder<List<Product>>(
            future: cartData.loadCart(context),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final cartProducts =
                    Provider.of<CartViewModel>(context).cartProducts;

                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.01)),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartData.cartProducts.length,
                        itemBuilder: (context, index) {
                          final product = cartProducts[index];
                          var item =
                              General.getSpecificCart(productId: int.parse(
                                  // snapshot.data![index].translations.ar ??
                                  '${cartData.cartProducts[index].id}'));

                          item ??= General.getSpecificCart(productId: int.parse(
                              // snapshot.data![index].translations.en ??
                              '${cartData.cartProducts[index].id}'));
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.002),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${product.name ?? ""} x ${item?.quantity}"),
                                Row(
                                  textDirection:
                                      Provider.of<NavMenuViewModel>(context)
                                                  .selectedCurrency
                                                  .country
                                                  ?.toLowerCase() ==
                                              "india"
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                  children: [
                                    Text(Provider.of<NavMenuViewModel>(context)
                                        .selectedCurrency
                                        .symbol!),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text((double.parse(item?.quantity.toString() ?? "1") *
                                            double.parse(product.salePrice?.isEmpty ??
                                                    false
                                                ? General()
                                                    .selectedCurrencyPrice(
                                                        price: product.price,
                                                        rate: Provider.of<NavMenuViewModel>(context)
                                                                .selectedCurrency
                                                                .rate ??
                                                            1.0)
                                                    .toStringAsFixed(2)
                                                : General()
                                                    .selectedCurrencyPrice(
                                                        price:
                                                            product.salePrice,
                                                        rate: Provider.of<NavMenuViewModel>(
                                                                    context)
                                                                .selectedCurrency
                                                                .rate ??
                                                            1.0)
                                                    .toStringAsFixed(2)))
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping fee"),
                          Row(
                            textDirection:
                                Provider.of<NavMenuViewModel>(context)
                                            .selectedCurrency
                                            .country
                                            ?.toLowerCase() ==
                                        "india"
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            children: [
                              Text(Provider.of<NavMenuViewModel>(context)
                                      .selectedCurrency
                                      .symbol ??
                                  ""),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(General()
                                  .selectedCurrencyPrice(
                                      price: viewModel.shippingMethods
                                          .firstWhere((element) =>
                                              element.id ==
                                              viewModel.selectedShippingMethod)
                                          .settings
                                          ?.cost
                                          ?.value,
                                      rate:
                                          Provider.of<NavMenuViewModel>(context)
                                                  .selectedCurrency
                                                  .rate ??
                                              1.00)
                                  .toStringAsFixed(2)),
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Mode"),
                          Text(viewModel.paymentMethods
                                  .firstWhere((element) =>
                                      element.id ==
                                      viewModel.selectedPaymentMethod?.id)
                                  .title ??
                              "")
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Loading());
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  viewModel.changeSelectedDetailTab(
                      viewModel.selectedOrderDetailTab - 1);
                },
                splashColor: Color.fromARGB(255, 142, 18, 59),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.01)),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  viewModel.addOrder(context);
                  viewModel.changeSelectedDetailTab(0);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.01)),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  itemTile(String iconName, String label, bool isActive, BuildContext context,
      bool firstTile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            firstTile
                ? Container()
                : Text(
                    '-----------',
                    style: TextStyle(
                        color: isActive ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.height * 0.015),
                  ),
            Column(
              children: [
                Image.asset(
                  'assets/icons/$iconName',
                  height: MediaQuery.of(context).size.height * 0.04,
                  color: isActive ? Colors.black : Colors.grey,
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: isActive ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  step1Process(BuildContext context) async {
    EasyLoading.show();
    if (viewModel.formKey.currentState?.validate() ?? false) {
      final sharedInstance = await SharedPreferences.getInstance();
      viewModel.selectedUserDetails = UserDetail(
          firstname: viewModel.firstnameController.text,
          lastname: viewModel.lastnameController.text,
          email: viewModel.emailController.text,
          mobile: viewModel.mobileController.text);

      if (viewModel.userDetails.isBlank ??
          false || viewModel.userDetails.isEmpty) {
        viewModel.userDetails.clear();
        viewModel.userDetails = userDetailFromJson(
            sharedInstance.getString('userDetailList') ?? '[]');
      }

      if (viewModel.userDetails.isBlank ??
          false || viewModel.userDetails.isEmpty) {
        viewModel.userDetails = [];
      }
      viewModel.userDetails.add(viewModel.selectedUserDetails ?? UserDetail());
      await sharedInstance.setString(
          'userDetailList', userDetailToJson(viewModel.userDetails));

      await sharedInstance.setString(
          'userNewDetail', json.encode(viewModel.selectedUserDetails));
      List<ShippingZone> zonesList =
          shippingZoneFromJson(sharedInstance.getString('zonesList') ?? '[]');
      if (zonesList.isBlank ?? false || zonesList.isEmpty) {
        zonesList.clear();

        zonesList = await viewModel.loadShippingZones(context);
        await sharedInstance.setString(
            'zonesList', shippingZoneToJson(zonesList));
        print("out zone data loop ${zonesList[0].toJson()}");
      }
      viewModel.shippingZone = zonesList;
      List<ShippingZoneLocation> countriesData = shippingZoneLocationFromJson(
          sharedInstance.getString('zonesLocationList') ?? '[]');
      if (countriesData.isBlank ?? false || countriesData.isEmpty) {
        countriesData.clear();
        zonesList.forEach((element) async {
          countriesData.addAll(
              await viewModel.loadShippingZonesLocation(context, element.id));
        });
        await sharedInstance.setString(
            'zonesLocationList', shippingZoneLocationToJson(countriesData));
        print("out zone location data loop $countriesData");
      }
      viewModel.shippingZoneLocations = countriesData;
      viewModel.changeSelectedDetailTab(viewModel.selectedOrderDetailTab + 1);
    }
    EasyLoading.dismiss();
  }

  orderProcessStep2(BuildContext context) {
    return IconStepper(
      icons: [
        Icon(Icons.supervised_user_circle),
        Icon(Icons.flag),
        Icon(Icons.access_alarm),
      ],
      enableNextPreviousButtons: false,

      // activeStep property set to activeStep variable defined above.
      activeStep:
          Provider.of<CheckoutViewModel>(context).selectedOrderDetailTab,

      // This ensures step-tapping updates the activeStep.
      onStepReached: (index) {},
    );
  }

  Widget _buildDataForm(
      BuildContext context, List<ShippingZoneLocation> countriesList) {
    final fillUserDetails =
        context.watch<CheckoutViewModel>().showfetchedUserDetails;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    viewModel.changeshowfetchedUserDetail(true);
                  },
                  child: Text(
                    'Shipping Address',
                    style: TextStyle(
                        fontSize: fillUserDetails
                            ? MediaQuery.of(context).size.width * 0.06
                            : MediaQuery.of(context).size.width * 0.03,
                        fontWeight: fillUserDetails
                            ? FontWeight.w600
                            : FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            viewModel.showfetchedUserDetails
                ? fillUserDetailForm(context)
                : savedDetailBox(context)
          ],
        ),
      ),
    );
  }

  savedDetailBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.03)),
      child: viewModel.userDetails.isEmpty
          ? Center(
              child: Text("No Saved Details."),
            )
          : AnimationLimiter(
              child: ListView.builder(
                itemCount: viewModel.userDetails.length,
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final userDetail = viewModel.userDetails[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.005),
                    child: AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              viewModel.changeSelectedUserdetail(userDetail);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.01,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Provider.of<CheckoutViewModel>(
                                                      context)
                                                  .selectedUserDetails ==
                                              userDetail
                                          ? Colors.black
                                          : Colors.grey),
                                  color: Colors.grey[300],
                                  boxShadow:
                                      Provider.of<CheckoutViewModel>(context)
                                                  .selectedUserDetails ==
                                              userDetail
                                          ? [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5.0,
                                              ),
                                            ]
                                          : [],
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width *
                                          0.01)),
                              child: Column(
                                children: [
                                  Text(
                                      "${userDetail.firstname} ${userDetail.lastname}"),
                                  Text(userDetail.email ?? ""),
                                  Text(userDetail.mobile ?? ""),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  fillUserDetailForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 10,
        // ),
        borderTextFormFeild(
            context: context,
            controller: viewModel.firstnameController,
            label: "First Name",
            hintvalue: "Ex: Alex",
            onsave: (value) {
              viewModel.firstname = value;
            },
            validateFunction: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.firstName');
              }
              return null;
            }),
        borderTextFormFeild(
            context: context,
            controller: viewModel.lastnameController,
            label: "Last Name",
            hintvalue: "Ex: Magu",
            onsave: (value) {
              viewModel.lastname = value;
            },
            validateFunction: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.lastName');
              }
              return null;
            }),

        borderTextFormFeild(
            context: context,
            controller: viewModel.emailController,
            label: "Email",
            hintvalue: "Ex: AlexMagu312@example.com",
            onsave: (value) {
              viewModel.email = value;
            },
            validateFunction: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.email');
              }
              if (!GetUtils.isEmail(value ?? "")) {
                return General.getTranslatedText(context, 'errors.emailformat');
              }
              return null;
            }),
        PhoneNumberFormFeild(
            context: context,
            controller: viewModel.mobileController,
            label: "Mobile Number",
            hintvalue: "Ex: 7966453619",
            keyboardtype: TextInputType.phone,
            onsave: (value) {
              viewModel.mobile = value;
              viewModel.mobileController.text = value ?? "";
            },
            validateFunction: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(
                    context, 'errors.mobileNumber');
              }

              return null;
            }),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),

        dropDownTextFormFeild(
          controller: viewModel.countryController,
          context: context,
          label: "Country",
          hintvalue: "Select a country",
          codesList: countryCodeList,
          validateFunction: (value) {
            if (GetUtils.isBlank(value) ?? true) {
              return General.getTranslatedText(context, 'errors.country');
            }
            return null;
          },
          onsave: (string) {
            viewModel.countryController.text = string ?? "";
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),

        borderTextFormFeild(
          controller: viewModel.cityController,
          context: context,
          label: "City",
          hintvalue: "Ex: Mumbai",
          onsave: (value) {
            viewModel.city = value;
          },
          validateFunction: (value) {
            if (GetUtils.isBlank(value) ?? true) {
              return General.getTranslatedText(context, 'errors.city');
            }
            return null;
          },
        ),
        borderTextFormFeild(
          controller: viewModel.addressController,
          context: context,
          label: "Street Address",
          hintvalue: "Ex: 7-a, Near old town road",
          onsave: (value) {
            viewModel.city = value;
          },
          validateFunction: (value) {
            if (GetUtils.isBlank(value) ?? true) {
              return General.getTranslatedText(context, 'errors.street');
            }
            return null;
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              splashColor: Color.fromARGB(255, 142, 18, 59),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.01)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Expanded(
                child: InkWell(
              onTap: () async {
                if (viewModel.formKey.currentState!.validate()) {
                  viewModel.formKey.currentState!.save();
                  EasyLoading.show();

                  final selectedCountryCode = viewModel.countryCodeList
                      .firstWhere((element) =>
                          CountryParser.parse(element.code).name ==
                          viewModel.countryController.text);

                  viewModel.shippingZone.forEach((zone) async {
                    final currentCountrycodes = await viewModel
                        .loadShippingZonesLocation(context, zone.id);
                    currentCountrycodes.forEach((element) {
                      print(element.code);
                    });
                    print("selected country code ${selectedCountryCode.code}");
                    final selectedZone = currentCountrycodes.where(
                        (element) => element.code == selectedCountryCode.code);
                    if (selectedZone.isNotEmpty) {
                      viewModel.changeShippingZoneV2(zone.id);

                      await viewModel.loadShippingMethods(context, zone.id);
                      print("found zone ${zone}");
                    } else {
                      print("not found any");
                    }
                  });
                  EasyLoading.dismiss();
                  viewModel.changeSelectedDetailTab(
                      viewModel.selectedOrderDetailTab + 1);
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.01)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ],
    );
  }
}

// InkWell(
//   onTap: () {
//     viewModel.changeshowfetchedUserDetail(false);
//   },
//   child: Text(
//     'Previous Details',
//     style: TextStyle(
//         fontSize: fillUserDetails
//             ? MediaQuery.of(context).size.width * 0.03
//             : MediaQuery.of(context).size.width * 0.06,
//         fontWeight:
//             fillUserDetails ? FontWeight.w500 : FontWeight.w600),
//   ),
// ),

// CustomTextFormField(
//   hint: General.getTranslatedText(context, 'checkout.firstName'),
//   controller: viewModel.firstnameController,
//   onSave: (value) {
//     viewModel.firstname = value;
//   },
//   validate: (value) {
//     if (GetUtils.isBlank(value) ?? true) {
//       return General.getTranslatedText(context, 'errors.emptyField');
//     }
//     return null;
//   },
// ),
// SizedBox(
//   height: 10,
// ),

// CustomTextFormField(
//   hint: General.getTranslatedText(context, 'checkout.lastName'),
//   controller: viewModel.lastnameController,
//   onSave: (value) {
//     viewModel.lastname = value;
//   },
//   validate: (value) {
//     if (GetUtils.isBlank(value) ?? true) {
//       return General.getTranslatedText(context, 'errors.emptyField');
//     }
//     return null;
//   },
// ),
// SizedBox(
//   height: 10,
// ),

// CustomTextFormField(
//   hint: General.getTranslatedText(context, 'checkout.email'),
//   controller: viewModel.emailController,
//   textInputType: TextInputType.emailAddress,
//   onSave: (value) {
//     viewModel.email = value;
//   },
//   validate: (value) {
//     if (GetUtils.isBlank(value) ?? true) {
//       return General.getTranslatedText(context, 'errors.emptyField');
//     }
//     if (!GetUtils.isEmail(value)) {
//       return General.getTranslatedText(context, 'errors.invalid');
//     }
//     return null;
//   },
// ),
// SizedBox(
//   height: 10,
// ),

//  viewModel.city = value;
//  {
//   if (GetUtils.isBlank(value) ?? true) {
//     return General.getTranslatedText(context, 'errors.emptyField');
//   }
//   return null;
// }

// CustomTextFormField(
//   hint: General.getTranslatedText(context, 'checkout.mobile'),
//   controller: viewModel.mobileController,
//   textInputType: TextInputType.phone,
//   onSave: (value) {
//     viewModel.mobile = value;
//   },
//   validate: (value) {
//     if (GetUtils.isBlank(value) ?? true) {
//       return General.getTranslatedText(context, 'errors.emptyField');
//     }
//     if (!GetUtils.isPhoneNumber(value)) {
//       return General.getTranslatedText(context, 'errors.invalid');
//     }
//     return null;
//   },
// ),

//  Stepper(
//   currentStep:
//       Provider.of<CheckoutViewModel>(context).selectedOrderDetailTab,
//   onStepCancel: () {
//     if (viewModel.selectedOrderDetailTab == 0) {
//     } else {
//       viewModel
//           .changeSelectedDetailTab(viewModel.selectedOrderDetailTab - 1);
//     }
//   },
//   onStepContinue: () async {
//     if (viewModel.selectedOrderDetailTab == 2) {
//     } else {
//       if (viewModel.selectedOrderDetailTab == 0) {
//         await step1Process(context);
//         // viewModel.addOrder2(context);
//       } else {
//         viewModel.changeSelectedDetailTab(
//             viewModel.selectedOrderDetailTab + 1);
//       }
//     }
//   },
//   onStepTapped: (int index) {
//     // viewModel.changeSelectedDetailTab(index);
//   },
//   type: StepperType.horizontal,
//   steps: <Step>[
//     Step(
//         state:
//             context.watch<CheckoutViewModel>().selectedOrderDetailTab > 0
//                 ? StepState.complete
//                 : StepState.editing,
//         title: const Text('Details'),
//         content: _buildDataForm(context),
//         isActive: Provider.of<CheckoutViewModel>(context)
//                 .selectedOrderDetailTab >=
//             0),
//     Step(
//         title: Text('Address'),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(
//                       MediaQuery.of(context).size.width * 0.03)),
//               padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width * 0.03,
//                   vertical: MediaQuery.of(context).size.height * 0.02),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.add,
//                     size: MediaQuery.of(context).size.width * 0.04,
//                   ),
//                   Text('Select Address')
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Text(
//               'Add New Address',
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   fontSize: MediaQuery.of(context).size.width * 0.045,
//                   fontWeight: FontWeight.bold),
//             ),
//             Form(
//                 child: Column(
//               children: [
//                 viewModel.shippingZoneLocations.isNotEmpty
//                     ? Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.grey,
//                             ),
//                             borderRadius: BorderRadius.circular(
//                                 MediaQuery.of(context).size.width *
//                                     0.01)),
//                         padding: EdgeInsets.symmetric(
//                             vertical:
//                                 MediaQuery.of(context).size.height * 0.01,
//                             horizontal:
//                                 MediaQuery.of(context).size.width * 0.01),
//                         child: DropdownSearch<String>(
//                           popupProps: PopupProps.menu(
//                             showSelectedItems: true,
//                             disabledItemFn: (String s) =>
//                                 s.startsWith('I'),
//                           ),
//                           items: (viewModel.shippingZoneLocations
//                               .map((e) => e.code)).toList(),
//                           dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                               labelText: "Select a country",
//                               hintText: "choose from a list of countries",
//                             ),
//                           ),
//                           onChanged: (value) {
//                             viewModel.changeShippingZoneLocation(value);
//                           },
//                           selectedItem:
//                               viewModel.selectedShippingZoneLocation,
//                         ))
//                     : Text("no data")
//               ],
//             ))
//           ],
//         ),
//         isActive: Provider.of<CheckoutViewModel>(context)
//                 .selectedOrderDetailTab >=
//             1),
//     Step(
//         title: Text('Payment'),
//         content: Text('Payment'),
//         isActive: Provider.of<CheckoutViewModel>(context)
//                 .selectedOrderDetailTab ==
//             2),
//   ],
// ),

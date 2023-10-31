import 'package:Jouri/ui/account/orders/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../components/loading.dart';
import '../../../components/order_card.dart';
import '../../../models/order.dart';
import '../../../utilities/general.dart';
import '../../app_bar/app_bar.dart';
import '../../app_bar/app_bar_view_model.dart';
import '../../cart/cart_view_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ordersData = Provider.of<OrdersViewModel>(context, listen: false);
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    LocalizedText(
                      'navMenu.orders',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ordersData.loadedOrders.isEmpty
                        ? FutureBuilder<List<Order>>(
                            future: ordersData.loadOrders(context, currentLang),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return OrderCard(
                                              order: snapshot.data![index],
                                              currency: currency.symbol!);
                                        })
                                    : Center(
                                        child: Container(
                                            height: 400,
                                            child: Lottie.asset(
                                              'assets/lottie/empty_orders.json',
                                              repeat: false,
                                              // reverse: true,
                                              alignment: Alignment.center,
                                              width: 250,
                                            )),
                                      );
                              } else {
                                return Center(child: Loading());
                              }
                            })
                        : ordersData.loadedOrders.isNotEmpty
                            ? ListView.builder(
                                itemCount: ordersData.loadedOrders.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return OrderCard(
                                      order: ordersData.loadedOrders[index],
                                      currency: currency.symbol!);
                                })
                            : Center(
                                child: Container(
                                    height: 400,
                                    child: Lottie.asset(
                                      'assets/lottie/empty_orders.json',
                                      repeat: false,
                                      // reverse: true,
                                      alignment: Alignment.center,
                                      width: 250,
                                    )),
                              )
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

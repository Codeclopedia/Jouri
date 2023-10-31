import 'package:Jouri/utilities/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../home/home_page_screen.dart';
import '../home/home_page_view_model.dart';

class OrderComplete extends StatelessWidget {
  final Order order;

  const OrderComplete({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    General.clearCart();
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
                builder: (_) => ChangeNotifierProvider(
                      create: (context) => HomePageViewModel(),
                      child: const HomePageScreen(),
                    )),
            (route) => false);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ///App bar
              // MultiProvider(providers: [
              //   ChangeNotifierProvider(
              //     create: (context) => AppBarViewModel(withCartButton: false),
              //   ),
              //   ChangeNotifierProvider(
              //     create: (context) => CartViewModel(),
              //   ),
              // ], child: const AppBarSection()),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${General.getTranslatedText(context, 'checkout.orderId')} #${order.id}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${General.getTranslatedText(context, 'checkout.success')}',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${General.getTranslatedText(context, 'checkout.thank')}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          color: Colors.grey.shade300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                    '${order.billing!.firstName} ${order.billing!.lastName}'),
                              ),
                              ListTile(
                                title: Text('${order.billing!.email}'),
                              ),
                              ListTile(
                                title: Text('${order.billing!.phone}'),
                              ),
                              ListTile(
                                title: Text('${order.total} ${order.currency}'),
                              ),
                              ListTile(
                                title: Text(
                                    '${order.billing!.address1}/${order.billing!.city}'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                    create: (context) => HomePageViewModel(),
                                    child: const HomePageScreen(),
                                  )),
                          (route) => false);
                    },
                    child: Text(
                      General.getTranslatedText(context, 'checkout.homePage'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

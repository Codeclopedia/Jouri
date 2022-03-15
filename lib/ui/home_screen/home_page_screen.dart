import 'package:Jouri/ui/home_screen/home_page_view_model.dart';
import 'package:Jouri/ui/home_screen/tabs/collections_tab/collections_tab_screen.dart';
import 'package:Jouri/ui/home_screen/tabs/collections_tab/collections_tab_view_model.dart';
import 'package:Jouri/ui/home_screen/tabs/fabrics_tab/fabrics_tab_screen.dart';
import 'package:Jouri/ui/home_screen/tabs/fabrics_tab/fabrics_tab_view_model.dart';
import 'package:Jouri/ui/home_screen/tabs/latest_products_tab/latest_products_tab_screen.dart';
import 'package:Jouri/ui/home_screen/tabs/latest_products_tab/latest_products_tab_view_model.dart';
import 'package:Jouri/ui/home_screen/tabs/on_sale_tab/on_sale_tab_screen.dart';
import 'package:Jouri/ui/home_screen/tabs/on_sale_tab/on_sale_tab_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../nav_menu/nav_menu.dart';
import '../nav_menu/nav_menu_view_model.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeScreenData = Provider.of<HomePageViewModel>(context);
    var activeTabStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      letterSpacing: 2.4,
      fontSize: 25,
    );
    // var onSaleTagStyle = const TextStyle(
    //   color: Color(0xffc91f1f),
    //   fontSize: 25,
    //   fontWeight: FontWeight.w500,
    //   fontStyle: FontStyle.normal,
    //   letterSpacing: 2.4,
    // );
    // var inactiveTabStyle = const TextStyle(
    //   color: Color(0xffadafb5),
    //   letterSpacing: 2.4,
    //   fontSize: 25,
    // );

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
        elevation: 0,
      ),
      drawer: ChangeNotifierProvider(
          create: (context) => NavMenuViewModel(), child: const NavMenu()),
      drawerScrimColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      homeScreenData.callLatestProductsTab(context);
                    },
                    child: LocalizedText(
                      'homeScreen.newIn',
                      style: homeScreenData.latest
                          ? activeTabStyle
                          : activeTabStyle.copyWith(
                              color: const Color(0xffadafb5),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      homeScreenData.callCollectionsTab(context);
                    },
                    child: LocalizedText(
                      'homeScreen.collections',
                      style: homeScreenData.collections
                          ? activeTabStyle
                          : activeTabStyle.copyWith(
                              color: const Color(0xffadafb5)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      homeScreenData.callFabricsTab(context);
                    },
                    child: LocalizedText(
                      'homeScreen.fabrics',
                      style: homeScreenData.fabrics
                          ? activeTabStyle
                          : activeTabStyle.copyWith(
                              color: const Color(0xffadafb5)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      homeScreenData.callOnSaleTab(context);
                    },
                    child: LocalizedText(
                      'homeScreen.onSale',
                      style: homeScreenData.onSale
                          ? activeTabStyle.copyWith(
                              color: const Color(0xffc91f1f),
                            )
                          : activeTabStyle.copyWith(
                              color: const Color(0xffadafb5),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            homeScreenData.latest
                ? ChangeNotifierProvider(
                    create: (context) => LatestProductsTabViewModel(),
                    child: const LatestProductsTab())
                : Container(),
            homeScreenData.collections
                ? ChangeNotifierProvider(
                    create: (context) => CollectionsTabViewModel(),
                    child: const CollectionsTab())
                : Container(),
            homeScreenData.fabrics
                ? ChangeNotifierProvider(
                    create: (context) => FabricsTabViewModel(),
                    child: const FabricsTab())
                : Container(),
            homeScreenData.onSale
                ? ChangeNotifierProvider(
                    create: (context) => OnSaleTabViewModel(),
                    child: const OnSaleTab())
                : Container(),
          ],
        ),
      ),
    );
  }
}

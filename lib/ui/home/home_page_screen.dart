import 'package:Jouri/ui/app_bar/app_bar.dart';
import 'package:Jouri/ui/app_bar/app_bar_view_model.dart';
import 'package:Jouri/ui/home/home_page_view_model.dart';
import 'package:Jouri/ui/home/tabs/collections_tab/collections_tab.dart';
import 'package:Jouri/ui/home/tabs/collections_tab/collections_tab_view_model.dart';
import 'package:Jouri/ui/home/tabs/fabrics_tab/fabrics_tab.dart';
import 'package:Jouri/ui/home/tabs/fabrics_tab/fabrics_tab_view_model.dart';
import 'package:Jouri/ui/home/tabs/latest_products_tab/latest_products_tab.dart';
import 'package:Jouri/ui/home/tabs/latest_products_tab/latest_products_tab_view_model.dart';
import 'package:Jouri/ui/home/tabs/on_sale_tab/on_sale_tab.dart';
import 'package:Jouri/ui/home/tabs/on_sale_tab/on_sale_tab_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../cart/cart_view_model.dart';
import '../nav_menu/nav_menu.dart';
import '../nav_menu/nav_menu_view_model.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeScreenData = Provider.of<HomePageViewModel>(context);
    var tabStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      letterSpacing: 2.4,
      fontSize: 25,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff8f9ff),
        drawer: ChangeNotifierProvider(
            create: (context) => NavMenuViewModel(), child: const NavMenu()),
        drawerScrimColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// app bar
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
                height: 80,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        homeScreenData.callLatestProductsTab(context);
                      },
                      child: LocalizedText(
                        'homePage.newIn',
                        style: homeScreenData.latest
                            ? tabStyle
                            : tabStyle.copyWith(
                                color: const Color(0xffadafb5),
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        homeScreenData.callCollectionsTab(context);
                      },
                      child: LocalizedText(
                        'homePage.collections',
                        style: homeScreenData.collections
                            ? tabStyle
                            : tabStyle.copyWith(
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
                        'homePage.fabrics',
                        style: homeScreenData.fabrics
                            ? tabStyle
                            : tabStyle.copyWith(
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
                        'homePage.onSale',
                        style: homeScreenData.onSale
                            ? tabStyle.copyWith(
                                color: const Color(0xffc91f1f),
                              )
                            : tabStyle.copyWith(
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
      ),
    );
  }
}

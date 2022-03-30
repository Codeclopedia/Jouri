import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/loading.dart';
import '../../models/category.dart';
import '../../utilities/general.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navMenuData = Provider.of<NavMenuViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    TextDirection direction =
        currentLang == 'ar' ? TextDirection.rtl : TextDirection.ltr;
    TextStyle itemStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 2.8,
    );

    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            // leading: Icon(
            //   Icons.language,
            //   color: Theme.of(context).colorScheme.secondary,
            // ),
            title: Text(
              currentLang == 'ar' ? 'English' : 'عربي',
              textDirection: direction,
              style: itemStyle,
            ),
            onTap: () {
              currentLang == 'ar'
                  ? General.changeLanguage(context, 'en')
                  : General.changeLanguage(context, 'ar');
            },
          ),
          ListTile(
            // leading: Icon(
            //   Icons.monetization_on_outlined,
            //   color: Theme.of(context).colorScheme.secondary,
            // ),
            title: LocalizedText(
              'navMenu.onSale',
              textDirection: direction,
              style: itemStyle.copyWith(color: const Color(0xffc91f1f)),
            ),
            onTap: () {
              navMenuData.navigateToArchiveScreenAsOnSale(context);
            },
          ),

          ///my account
          navMenuData.customer == null
              ? ListTile(
                  // leading: Icon(
                  //   Icons.person_outlined,
                  //   color: Theme.of(context).colorScheme.secondary,
                  // ),
                  title: LocalizedText(
                    'navMenu.login',
                    textDirection: direction,
                    style: itemStyle.copyWith(color: const Color(0xff1fc95a)),
                  ),
                  onTap: () {
                    navMenuData.navigateToLogin(context);
                  },
                )
              : ExpansionTile(title: LocalizedText('navMenu.myAccount',style: itemStyle,),children: [
                    ListTile(
                      // leading: Icon(
                      //   Icons.favorite_border,
                      //   color: Theme.of(context).colorScheme.secondary,
                      // ),
                      title: LocalizedText(
                        'navMenu.favourite',
                        textDirection: direction,
                        style: itemStyle,
                      ),
                      onTap: () {
                        navMenuData.navigateToFavourite(context);
                      },
                    ),
                     ListTile(
                      title: LocalizedText(
                        'navMenu.orders',
                        textDirection: direction,
                        style: itemStyle,
                      ),
                      onTap: () {
                        // navMenuData.navigateToFavourite(context);
                      },
                    ),
                     ListTile(
                      title: LocalizedText(
                        'navMenu.account',
                        textDirection: direction,
                        style: itemStyle,
                      ),
                      onTap: () {
                        // navMenuData.navigateToFavourite(context);
                      },
                    ),
                     ListTile(
                      title: LocalizedText(
                        'navMenu.logOut',
                        textDirection: direction,
                        style: itemStyle.copyWith(color: const Color(0xffc91f1f)),
                      ),
                      onTap: () {
                        navMenuData.logOut();
                      },
                    ),

              ],),
          const Divider(),

          ///load Parent categories -- level 0
          FutureBuilder<List<Category>>(
              future: navMenuData.loadCategories(context, currentLang),
              builder: (context, snapshot0) {
                if (snapshot0.hasData) {
                  return ListView.builder(
                    itemCount: snapshot0.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot0.data![index].hasChildren == true

                          ///level 0 has children
                          ? ExpansionTile(
                              title: InkWell(
                                onTap: () {
                                  navMenuData.navigateToArchiveScreenAsCategory(
                                      context,
                                      snapshot0.data![index].id,
                                      snapshot0.data![index].name,
                                      snapshot0.data![index].description,
                                      null);
                                },
                                child: Text(
                                  snapshot0.data![index].name!,
                                  textDirection: direction,
                                  style: itemStyle,
                                ),
                              ),
                              // leading: snapshot0.data![index].image != null
                              //     ? Image.network(
                              //         snapshot0.data![index].image!.src!,
                              //         width: 40,
                              //         height: 30,
                              //         fit: BoxFit.cover,
                              //       )
                              //     : const Text(
                              //         '',
                              //       ),
                              trailing: const Icon(Icons.add),
                              maintainState: true,
                              childrenPadding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              collapsedIconColor:
                                  Theme.of(context).primaryColor,
                              iconColor:
                                  Theme.of(context).colorScheme.secondary,
                              textColor:
                                  Theme.of(context).colorScheme.secondary,
                              collapsedTextColor:
                                  Theme.of(context).primaryColor,
                              children: [
                                ///load sub-categories -- level 1
                                FutureBuilder<List<Category>>(
                                    future: navMenuData.loadSubCategory(context,
                                        snapshot0.data![index].id, currentLang),
                                    builder: (context, snapshot1) {
                                      if (snapshot1.hasData) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot1.data!.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return snapshot1.data![i]
                                                          .hasChildren ==
                                                      true

                                                  ///level 1 has children
                                                  ? ExpansionTile(
                                                      title: InkWell(
                                                        onTap: () {
                                                          navMenuData
                                                              .navigateToArchiveScreenAsCategory(
                                                                  context,
                                                                  snapshot1
                                                                      .data![i]
                                                                      .id,
                                                                  snapshot1
                                                                      .data![i]
                                                                      .name,
                                                                  snapshot1
                                                                      .data![i]
                                                                      .description,
                                                                  snapshot0
                                                                      .data![
                                                                          index]
                                                                      .name);
                                                        },
                                                        child: Text(
                                                          snapshot1
                                                              .data![i].name!,
                                                          textDirection:
                                                              direction,
                                                          style: itemStyle,
                                                        ),
                                                      ),
                                                      // leading: snapshot1
                                                      //             .data![i]
                                                      //             .image !=
                                                      //         null
                                                      //     ? Image.network(
                                                      //         snapshot1.data![i]
                                                      //             .image!.src!,
                                                      //         width: 40,
                                                      //         fit: BoxFit.cover,
                                                      //       )
                                                      //     : const Text(
                                                      //         '',
                                                      //       ),
                                                      maintainState: true,
                                                      trailing:
                                                          const Icon(Icons.add),
                                                      childrenPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 40),
                                                      collapsedIconColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      iconColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                      textColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                      collapsedTextColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      children: [
                                                        ///load sub-sub-categories -- level 2
                                                        FutureBuilder<
                                                                List<Category>>(
                                                            future: navMenuData
                                                                .loadSubCategory(
                                                                    context,
                                                                    snapshot1
                                                                        .data![
                                                                            i]
                                                                        .id,
                                                                    currentLang),
                                                            builder: (context,
                                                                snapshot2) {
                                                              if (snapshot2
                                                                  .hasData) {
                                                                return ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: snapshot2
                                                                            .data!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int y) {
                                                                          return ListTile(
                                                                            title:
                                                                                Text(
                                                                              snapshot2.data![y].name!,
                                                                              textDirection: direction,
                                                                              style: itemStyle,
                                                                            ),
                                                                            // leading: snapshot2.data![y].image != null
                                                                            //     ? Image.network(
                                                                            //         snapshot2.data![y].image!.src!,
                                                                            //         width: 40,
                                                                            //         height: 30,
                                                                            //         fit: BoxFit.cover,
                                                                            //       )
                                                                            //     : const Text(
                                                                            //         '',
                                                                            //       ),
                                                                            onTap:
                                                                                () {
                                                                              navMenuData.navigateToArchiveScreenAsCategory(context, snapshot2.data![y].id, snapshot2.data![y].name, snapshot2.data![y].description, snapshot1.data![i].name);
                                                                            },
                                                                          );
                                                                        });
                                                              } else {
                                                                return const Center(
                                                                    child:
                                                                        Loading());
                                                              }
                                                            })
                                                      ],
                                                    )

                                                  ///level 1 has no children
                                                  : ListTile(
                                                      title: Text(
                                                        snapshot1
                                                            .data![i].name!,
                                                        textDirection:
                                                            direction,
                                                        style: itemStyle,
                                                      ),
                                                      // leading: snapshot1
                                                      //             .data![i]
                                                      //             .image !=
                                                      //         null
                                                      //     ? Image.network(
                                                      //         snapshot1.data![i]
                                                      //             .image!.src!,
                                                      //         width: 40,
                                                      //         height: 30,
                                                      //         fit: BoxFit.cover,
                                                      //       )
                                                      //     : const Text(
                                                      //         '',
                                                      //       ),
                                                      onTap: () {
                                                        navMenuData
                                                            .navigateToArchiveScreenAsCategory(
                                                                context,
                                                                snapshot1
                                                                    .data![i]
                                                                    .id,
                                                                snapshot1
                                                                    .data![i]
                                                                    .name,
                                                                snapshot1
                                                                    .data![i]
                                                                    .description,
                                                                snapshot0
                                                                    .data![
                                                                        index]
                                                                    .name);
                                                      },
                                                    );
                                            });
                                      } else {
                                        return const Center(
                                          child: Loading(),
                                        );
                                      }
                                    })
                              ],
                            )

                          ///level 0 has no children
                          : ListTile(
                              title: Text(
                                snapshot0.data![index].name!,
                                textDirection: direction,
                                style: itemStyle,
                              ),
                              // leading: snapshot0.data![index].image != null
                              //     ? Image.network(
                              //         snapshot0.data![index].image!.src!,
                              //         width: 40,
                              //         height: 30,
                              //         fit: BoxFit.cover,
                              //       )
                              //     : const Text(
                              //         '',
                              //       ),
                              onTap: () {
                                navMenuData.navigateToArchiveScreenAsCategory(
                                    context,
                                    snapshot0.data![index].id,
                                    snapshot0.data![index].name,
                                    snapshot0.data![index].description,
                                    null);
                              },
                            );
                    },
                  );
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              }),
        ],
      ),
    );
  }
}

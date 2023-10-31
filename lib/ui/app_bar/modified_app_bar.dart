import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';

import '../cart/cart_view_model.dart';
import 'app_bar_view_model.dart';

class ModifiedAppBarSection extends StatelessWidget {
  final Function() onbackPressed;
  const ModifiedAppBarSection({Key? key, required this.onbackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBarData = Provider.of<AppBarViewModel>(context, listen: false);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: const Text(
            'Free Shipping above 20 KD',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11, letterSpacing: 2.2, color: Colors.white),
          ),
        ),
        AppBar(
          actions: [
            appBarData.withCartButton
                ? Consumer<CartViewModel>(
                    builder: (context, viewModel, _) {
                      return IconButton(
                        onPressed: () {
                          appBarData.navigateToCart(context);
                        },
                        icon: badge.Badge(
                            showBadge: Provider.of<AppBarViewModel>(context)
                                .newCartItemIcon,
                            badgeColor: Theme.of(context).colorScheme.secondary,
                            badgeContent: Text(
                              '',
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: Icon(
                              CupertinoIcons.bag,
                              color: Theme.of(context).primaryColor,
                            )),
                      );
                    },
                  )
                : Container()
          ],
          title: Image.asset(
            'assets/images/logo.png',
            width: 50,
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: onbackPressed(),
            child: Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }
}

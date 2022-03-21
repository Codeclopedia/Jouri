import 'package:Jouri/ui/app_bar/app_bar_view_model.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/cart_view_model.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Consumer<AppBarViewModel>(
              builder: (context, viewModel, _) {
                return viewModel.withCartButton
                    ? IconButton(
                        onPressed: () {
                          viewModel.navigateToCart(context);
                        },
                        icon: Badge(
                            badgeContent: Text(
                              '${viewModel.cartCount}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 8),
                            ),
                            child: Icon(
                              CupertinoIcons.bag,
                              color: Theme.of(context).primaryColor,
                            )),
                      )
                    : Container();
              },
            ),
          ],
          title: Image.asset(
            'assets/images/logo.png',
            width: 50,
          ),
          centerTitle: true,
        ),
      ],
    );
  }
}

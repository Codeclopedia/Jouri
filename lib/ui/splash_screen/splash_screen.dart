import 'package:Jouri/ui/splash_screen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components/loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splashScreenData = Provider.of<SplashScreenViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/full_logo.png',
              width: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const Loading(),
          ],
        ),
      ),
    );
  }
}

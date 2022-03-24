import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../home/home_page_screen.dart';
import '../home/home_page_view_model.dart';


class SplashScreenViewModel extends ChangeNotifier {
  final BuildContext context;

  SplashScreenViewModel(this.context) {
    _checkDataAndNavigate();
    // _getToken();
  }

  // void _getToken() async {
  //   var firebaseToken = await FirebaseMessaging.instance.getToken();
  //   print(firebaseToken);
  //   General.setStringSP('fcmToken', firebaseToken ?? '');
  // }

  void _checkDataAndNavigate() async {
    ///maintenance & version
    //if we add Firebase remote config it will goes here
    // final remoteConfig = RemoteConfig.instance;
    // await remoteConfig.setConfigSettings(
    //   RemoteConfigSettings(
    //     fetchTimeout: Duration(seconds: 10),
    //     minimumFetchInterval: Duration(seconds: 10),
    //   ),
    // );
    // await remoteConfig.fetchAndActivate();
    // var appVersion = remoteConfig.getString(Constants.APP_VERSION);
    // var isAppNeedUpdate = await General.checkVersion(appVersion);
    // bool maintenance = remoteConfig.getBool(Constants.IN_MAINTENANCE);
    // print('need update $isAppNeedUpdate');
    // print('maintenance $maintenance');
    // if (isAppNeedUpdate) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       CupertinoPageRoute(
    //         builder: (_) => SpecialValueScreen(
    //           imagePath: 'assets/images/update.png',
    //           navButton: true,
    //           text: General.getTranslatedText(context, 'config.appUpdate'),
    //           androidLink: 'https://play.google.com/store/apps/details?id=',
    //           iosLink: 'https://apps.apple.com/jo/app/dageega/id1599568733',
    //         ),
    //       ),
    //           (route) => false);
    //   return;
    // }
    // if (maintenance) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       CupertinoPageRoute(
    //         builder: (_) => SpecialValueScreen(
    //           imagePath: 'assets/images/maintenance.png',
    //           navButton: false,
    //           text: General.getTranslatedText(context, 'config.appMaintenance'),
    //         ),
    //       ),
    //           (route) => false);
    //   return;
    // }
    //checking User if exist
    ///user
    // if (await General.checkUserAvailability()) {
    //   var user = User.fromJson(await General.getUser() ?? '');
    //   var url = Constants.BASE_URL + Constants.SIGN_UP + '/${user.id}';
    //   await HttpRequests.httpGetRequest(
    //     context: context,
    //     url: url,
    //     headers: {},
    //     success: (value, _) {
    //       user = User.fromJson(value);
    //       General.saveUser(user.toJson());
    //       Future.delayed(
    //         Duration(seconds: 2),
    //             () {
    //           Navigator.pushAndRemoveUntil(
    //               context,
    //               CupertinoPageRoute(
    //                 builder: (_) => BottomNavigationBarr(user),
    //               ),
    //                   (route) => false);
    //         },
    //       );
    //     },
    //     error: () {},
    //   );
    // } else {
    //   Future.delayed(
    //     Duration(seconds: 3),
    //         () {
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           CupertinoPageRoute(
    //             builder: (_) => ChangeNotifierProvider(
    //               create: (context) => LoginViewModel(),
    //               child: Login(),
    //             ),
    //           ),
    //               (route) => false);
    //     },
    //   );
    // }
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (context) => HomePageViewModel(),
                child: const HomePageScreen(),
              ),
            ),
            (route) => false);
      },
    );
  }
}

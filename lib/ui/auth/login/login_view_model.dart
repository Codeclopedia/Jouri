import 'dart:convert';

import 'package:Jouri/utilities/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';
import '../../../utilities/http_requests.dart';
import '../../home/home_page_screen.dart';
import '../../home/home_page_view_model.dart';
import '../sign_up/sign_up_screen.dart';
import '../sign_up/sign_up_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  String? email, password;
  bool loading = false;
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  get Customer => null;

  login(context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loading = true;
      notifyListeners();
      var url = Constants.baseAuthUrl;
      await HttpRequests.httpPostRequest(
        context: context,
        url: url,
        headers: {},
        body: {
          'username': email,
          'password': password,
        }, //body
        success: (value) async {
          print(value);
          var map = json.decode(value);
          if (map['success']) {
            print(map['data']['token']);
            General.setStringSP('token', map['data']['token']);
            var url = Constants.baseUrl +
                Constants.customer +
                '/${map['data']['id']}' +
                Constants.wooAuth;
            await HttpRequests.httpGetRequest(
                context: context,
                url: url,
                headers: {},
                success: (value, _) {
                  var user = Customer.fromJson(value);
                  General.saveUser(user.toJson());
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                                create: (context) => HomePageViewModel(),
                                child: const HomePageScreen(),
                              )),
                      (route) => false);
                },
                error: () {
                  loading = false;
                  notifyListeners();
                });
          }
        },
        error: () {
          loading = false;
          notifyListeners();
        },
      );
    }
  }

  navigateToSignUp(context) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => SignUpViewModel(),
              child: const SignUpScreen(),
            )));
  }
}

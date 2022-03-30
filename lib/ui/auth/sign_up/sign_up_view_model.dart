import 'dart:convert';

import 'package:Jouri/ui/home/home_page_screen.dart';
import 'package:Jouri/ui/home/home_page_view_model.dart';
import 'package:Jouri/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/customer.dart';
import '../../../utilities/general.dart';
import '../../../utilities/http_requests.dart';

class SignUpViewModel extends ChangeNotifier {
  String? firstname, lastname, email, phone, password;
  bool loading = false;
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  launchTermsUrl() async {
    var url = Constants.termsPageUrl;
    if (!await launch(url)) throw 'Could not launch $url';
  }

  signUp(context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loading = true;
      notifyListeners();
      var url = Constants.baseUrl + Constants.customer + Constants.wooAuth;
      HttpRequests.httpPostRequest(
          context: context,
          url: url,
          headers: {},
          body: {
            "first_name": firstname,
            "last_name": lastname,
            "username": phone,
            "email": email,
            "password": password
          },
          success: (value) async {
            var url = Constants.baseAuthUrl;
            HttpRequests.httpPostRequest(
                context: context,
                url: url,
                headers: {},
                body: {
                  'username': email,
                  'password': password,
                },
                success: (data) {
                  var map = json.decode(data);
                  if (map['success']) {
                    loading = false;
                    notifyListeners();
                    General.setStringSP('token', map['data']['token']);
                    var user = Customer.fromJson(value);
                    General.saveUser(user.toJson());
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                                  create: (context) => HomePageViewModel(),
                                  child: const HomePageScreen(),
                                )),
                        (route) => false);
                  }
                },
                error: () {
                  loading = false;
                  notifyListeners();
                });
          },
          error: () {
            loading = false;
            notifyListeners();
          });
    }
  }
}

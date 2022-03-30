import 'package:Jouri/components/loading_overlay.dart';
import 'package:Jouri/ui/auth/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text_form_field.dart';
import '../../../utilities/general.dart';
import '../../app_bar/app_bar.dart';
import '../../app_bar/app_bar_view_model.dart';
import '../../cart/cart_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginData = Provider.of<LoginViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 21,
      fontWeight: FontWeight.bold,
      letterSpacing: 4.2,
    );

    return LoadingOverlay(
      isLoading: loginData.loading,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              ///app bar
              // ChangeNotifierProvider(
              //     create: (context) => AppBarViewModel(withCartButton: false),
              //     child: const AppBarSection()),
              MultiProvider(providers: [
                ChangeNotifierProvider(
                  create: (context) => AppBarViewModel(withCartButton: false),
                ),
                ChangeNotifierProvider(
                  create: (context) => CartViewModel(),
                ),
              ], child: const AppBarSection()),

              ///body
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      LocalizedText(
                        'auth.login',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: loginData.formKey,
                        child: Column(children: [
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.email'),
                            onSave: (value) {
                              loginData.email = value;
                            },
                            validate: (value) {
                              if (!GetUtils.isEmail(value)) {
                                return General.getTranslatedText(
                                    context, 'errors.invalid');
                              }
                              return null;
                            },
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.password'),
                            controller: loginData.passwordController,
                            onSave: (value) {
                              loginData.password = value;
                            },
                            validate: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return General.getTranslatedText(
                                    context, 'errors.empty');
                              }
                              return null;
                            },
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const LocalizedText('auth.login'),
                                onPressed: () {
                                  loginData.login(context);
                                },
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlineButton(
                                  child: LocalizedText(
                                    'auth.signUp',
                                    style: currentLang == 'ar'
                                        ? GoogleFonts.almarai(
                                            textStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 3.2,
                                          ))
                                        : GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 3.2,
                                          ),
                                  ),
                                  onPressed: () {
                                    loginData.navigateToSignUp(context);
                                  },
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

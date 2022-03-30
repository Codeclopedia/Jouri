import 'package:Jouri/components/loading_overlay.dart';
import 'package:Jouri/ui/auth/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text_form_field.dart';
import '../../../utilities/general.dart';
import '../../app_bar/app_bar.dart';
import '../../app_bar/app_bar_view_model.dart';
import '../../cart/cart_view_model.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var signUpData = Provider.of<SignUpViewModel>(context);

    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 21,
      fontWeight: FontWeight.bold,
      letterSpacing: 4.2,
    );

    return LoadingOverlay(
      isLoading: signUpData.loading,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                        'auth.signUp',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: signUpData.formKey,
                        child: Column(children: [
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.firstName'),
                            onSave: (value) {
                              signUpData.firstname = value;
                            },
                            validate: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return General.getTranslatedText(
                                    context, 'errors.emptyField');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.lastName'),
                            onSave: (value) {
                              signUpData.lastname = value;
                            },
                            validate: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return General.getTranslatedText(
                                    context, 'errors.emptyField');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.email'),
                            onSave: (value) {
                              signUpData.email = value;
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
                                context, 'auth.phone'),
                            onSave: (value) {
                              signUpData.phone = value;
                            },
                            validate: (value) {
                              if (!GetUtils.isPhoneNumber(value)) {
                                return General.getTranslatedText(
                                    context, 'errors.invalid');
                              }
                              return null;
                            },
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.password'),
                            controller: signUpData.passwordController,
                            onSave: (value) {
                              signUpData.password = value;
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
                            height: 25,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.confirmPassword'),
                            onSave: (value) {},
                            validate: (value) {
                              if (value == signUpData.passwordController.text) {
                                return null;
                              }
                              return General.getTranslatedText(
                                  context, 'errors.invalid');
                            },
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: signUpData.loading
                                      ? CircularProgressIndicator()
                                      : const LocalizedText('auth.signUp'),
                                  onPressed: () {
                                    signUpData.signUp(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocalizedText(
                                'auth.acceptTerms',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              InkWell(
                                child: LocalizedText(
                                  'auth.terms',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap: () {
                                  signUpData.launchTermsUrl();
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

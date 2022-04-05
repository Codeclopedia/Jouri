import 'package:Jouri/components/custom_text_form_field.dart';
import 'package:Jouri/ui/account/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utilities/general.dart';
import '../../app_bar/app_bar.dart';
import '../../app_bar/app_bar_view_model.dart';
import '../../cart/cart_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileData = Provider.of<ProfileViewModel>(context);
    var titleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 22,
      letterSpacing: 4.2,
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// app bar
              // ChangeNotifierProvider(
              //     create: (context) => AppBarViewModel(withCartButton: true),
              //     child: const AppBarSection()),
              // const SizedBox(
              //   height: 20,
              // ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 35.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    LocalizedText(
                      'navMenu.accountDetails',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profileData.editable
                            ? Container()
                            : TextButton.icon(
                                onPressed: () {
                                  profileData.changeEditable();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 18,
                                ),
                                label: LocalizedText(
                                  'profile.edit',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                        profileData.editable
                            ? TextButton.icon(
                                onPressed: () {
                                  profileData.cancelEditions();
                                  profileData.fillValues();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 18,
                                ),
                                label: LocalizedText(
                                  'profile.cancel',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ))
                            : Container(),
                      ],
                    ),
                    Form(
                      key: profileData.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.firstName'),
                            controller: profileData.firstNameController,
                            enable: profileData.editable,
                            onSave: (value) {
                              profileData.firstName = value;
                            },
                            validate: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return General.getTranslatedText(
                                    context, 'errors.emptyField');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.lastName'),
                            controller: profileData.lastNameController,
                            enable: profileData.editable,
                            onSave: (value) {
                              profileData.lastName = value;
                            },
                            validate: (value) {
                              if (GetUtils.isNullOrBlank(value)!) {
                                return General.getTranslatedText(
                                    context, 'errors.emptyField');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.email'),
                            controller: profileData.emailController,
                            enable: profileData.editable,
                            onSave: (value) {
                              profileData.email = value;
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
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            hint: General.getTranslatedText(
                                context, 'auth.phone'),
                            controller: profileData.phoneNumberController,
                            enable: false,
                            onSave: (value) {
                            },
                            validate: (value) {
                             
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    profileData.editable
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: LocalizedText('profile.saveChanges'),
                                  onPressed: () {
                                    {
                                      profileData.saveChanges(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

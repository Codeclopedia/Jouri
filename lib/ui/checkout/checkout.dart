import 'package:Jouri/components/custom_text_form_field.dart';
import 'package:Jouri/components/loading.dart';
import 'package:Jouri/models/checkout_models/shipping_zone_location.dart';
import 'package:Jouri/models/customer.dart';
import 'package:Jouri/models/checkout_models/shipping_method.dart';
import 'package:Jouri/ui/checkout/checkout_view_model.dart';
import 'package:Jouri/ui/checkout/new_checkout_design.dart';
import 'package:Jouri/utilities/general.dart';
import 'package:country_picker/country_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

import '../app_bar/app_bar.dart';
import '../app_bar/app_bar_view_model.dart';
import '../cart/cart_view_model.dart';

class Checkout extends StatelessWidget {
  final Customer? customer;

  Checkout({Key? key, this.customer}) : super(key: key);

  late CheckoutViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CheckoutViewModel>(context, listen: false);
    viewModel.fillData(customer);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff8f9ff),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///appBar
            MultiProvider(providers: [
              ChangeNotifierProvider(
                create: (context) => AppBarViewModel(withCartButton: false),
              ),
              ChangeNotifierProvider(
                create: (context) => CartViewModel(),
              ),
            ], child: const AppBarSection()),

            ///body
            Expanded(
              child: SingleChildScrollView(
                controller: viewModel.scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<CheckoutViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShippingZones(context),
                          _buildShippingZonesLocation(context),
                          _buildShippingMethod(context),
                          _buildPaymentMethod(context),
                          _buildDataForm(context),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.addOrder(context);
                  },
                  child: Text(
                    General.getTranslatedText(context, 'checkout.confirm'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildShippingZones(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                General.getTranslatedText(context, 'checkout.addressDetails'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            InkWell(
                onTap: () async {
                  EasyLoading.show();
                  final zones = await viewModel.loadShippingZones(context);
                  List<ShippingZoneLocation> countryCodeList = [];
                  zones.forEach((element) async {
                    final countryCodes = await viewModel
                        .loadShippingZonesLocation(context, element.id);
                    countryCodeList.addAll(countryCodes);
                  });
                  countryCodeList = countryCodeList.toSet().toList();
                  EasyLoading.dismiss();

                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (context) => CartViewModel(),
                                child: CheckoutDetailsPage(
                                  customer: customer,
                                  countryCodeList: countryCodeList,
                                ),
                              )));
                },
                child: Text('New design'))
          ],
        ),
        FutureBuilder(
          future: viewModel.loadShippingZones(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomRadioButton(
                radioButtonValue: viewModel.changeShippingZone,
                selectedColor: Theme.of(context).primaryColor,
                unSelectedColor: Colors.white,
                defaultSelected: viewModel.selectedShippingZone,
                radius: 10,
                shapeRadius: 10,
                padding: 0,
                horizontal: true,
                enableShape: true,
                autoWidth: true,
                unSelectedBorderColor: Colors.grey,
                buttonLables: viewModel.shippingZone
                    .map(
                      (e) => e.name,
                    )
                    .toList(),
                buttonValues: viewModel.shippingZone
                    .map(
                      (e) => e.id,
                    )
                    .toList(),
                elevation: 5,
              );
            }
            return Center(
              child: Loading(),
            );
          },
        ),
      ],
    );
  }

  _buildPaymentMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          General.getTranslatedText(context, 'checkout.selectPaymentMethod'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        FutureBuilder(
          future: viewModel.loadPaymentMethods(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  // child: CustomRadioButton(
                  //   // radioButtonValue: viewModel.changePaymentMethod(),
                  //   selectedColor: Theme.of(context).primaryColor,
                  //   unSelectedColor: Colors.white,
                  //   defaultSelected: viewModel.selectedPaymentMethod,
                  //   radius: 10,
                  //   shapeRadius: 10,
                  //   horizontal: true,
                  //   enableShape: true,
                  //   autoWidth: true,
                  //   unSelectedBorderColor: Colors.grey,
                  //   buttonLables: viewModel.paymentMethods
                  //       .map(
                  //         (e) => e.title ?? '',
                  //       )
                  //       .toList(),
                  //   buttonValues: viewModel.paymentMethods
                  //       .map(
                  //         (e) => e.id,
                  //       )
                  //       .toList(),
                  //   elevation: 5,
                  // ),
                  );
            }
            return Center(
              child: Loading(),
            );
          },
        ),
      ],
    );
  }

  _buildShippingZonesLocation(BuildContext context) {
    return viewModel.selectedShippingZone != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                General.getTranslatedText(context, 'checkout.location'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              FutureBuilder(
                future: viewModel.loadShippingZonesLocation(
                    context, viewModel.selectedShippingZone),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      child: CustomRadioButton(
                        padding: 0,
                        radioButtonValue: viewModel.changeShippingZoneLocation,
                        selectedColor: Theme.of(context).primaryColor,
                        unSelectedColor: Colors.white,
                        radius: 10,
                        shapeRadius: 10,
                        defaultSelected: viewModel.selectedShippingZoneLocation,
                        horizontal: true,
                        enableShape: true,
                        autoWidth: true,
                        unSelectedBorderColor: Colors.grey,
                        buttonLables: viewModel.shippingZoneLocations
                            .map(
                              (e) => CountryParser.parse(e.code).name,
                            )
                            .toList(),
                        buttonValues: viewModel.shippingZoneLocations
                            .map(
                              (e) => e.code,
                            )
                            .toList(),
                        elevation: 5,
                      ),
                    );
                  }
                  return Center(
                    child: Loading(),
                  );
                },
              ),
            ],
          )
        : Container();
  }

  _buildShippingMethod(BuildContext context) {
    return viewModel.selectedShippingZone != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                General.getTranslatedText(context, 'checkout.shippingMethod'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              FutureBuilder(
                future: viewModel.loadShippingMethods(
                    context, viewModel.selectedShippingZone),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return CustomRadioButton(
                      radioButtonValue: viewModel.changeShippingMethod,
                      selectedColor: Theme.of(context).primaryColor,
                      unSelectedColor: Colors.white,
                      radius: 10,
                      defaultSelected: viewModel.selectedShippingMethod,
                      shapeRadius: 10,
                      horizontal: true,
                      enableShape: true,
                      autoWidth: true,
                      unSelectedBorderColor: Colors.grey,
                      buttonLables: viewModel.shippingMethods
                          .map(
                            (e) => _fillTitle(context, e),
                          )
                          .toList(),
                      buttonValues: viewModel.shippingMethods
                          .map(
                            (e) => e.id,
                          )
                          .toList(),
                      elevation: 5,
                    );
                  }
                  return Center(
                    child: Loading(),
                  );
                },
              ),
            ],
          )
        : Container();
  }

  _buildDataForm(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.firstName'),
            controller: viewModel.firstnameController,
            onSave: (value) {
              viewModel.firstname = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.lastName'),
            controller: viewModel.lastnameController,
            onSave: (value) {
              viewModel.lastname = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.email'),
            controller: viewModel.emailController,
            textInputType: TextInputType.emailAddress,
            onSave: (value) {
              viewModel.email = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              if (!GetUtils.isEmail(value)) {
                return General.getTranslatedText(context, 'errors.invalid');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.mobile'),
            controller: viewModel.mobileController,
            textInputType: TextInputType.phone,
            onSave: (value) {
              viewModel.mobile = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              if (!GetUtils.isPhoneNumber(value)) {
                return General.getTranslatedText(context, 'errors.invalid');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.address'),
            controller: viewModel.addressController,
            onSave: (value) {
              viewModel.address = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.city'),
            controller: viewModel.cityController,
            onSave: (value) {
              viewModel.city = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: General.getTranslatedText(context, 'checkout.postal'),
            controller: viewModel.postalController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onSave: (value) {
              viewModel.postal = value;
            },
            validate: (value) {
              if (GetUtils.isBlank(value) ?? true) {
                return General.getTranslatedText(context, 'errors.emptyField');
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  String _fillTitle(context, ShippingMethod e) {
    if (e.methodId != 'free_shipping')
      return '${e.title}->${General.getTranslatedText(context, 'checkout.cost')}: ${e.settings?.cost?.value}';
    return '${e.title}';
  }
}

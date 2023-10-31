import 'package:Jouri/models/checkout_models/shipping_zone_location.dart';
import 'package:Jouri/ui/checkout/checkout_view_model.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

Widget borderTextFormFeild(
    {required TextEditingController controller,
    required BuildContext context,
    required String label,
    required String hintvalue,
    required Function(String?) onsave,
    TextInputType? keyboardtype,
    required Function(String?) validateFunction}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textformfeildheading(label: label, context: context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.01)),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: TextFormField(
            keyboardType: keyboardtype ?? TextInputType.emailAddress,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hintvalue,
                fillColor: Colors.white,
                hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.grey)),
            controller: controller,
            onSaved: (newValue) => onsave(newValue),
            validator: (value) => validateFunction(value),
          ),
        ),
      ],
    ),
  );
}

Widget PhoneNumberFormFeild(
    {required TextEditingController controller,
    required BuildContext context,
    required String label,
    required String hintvalue,
    required Function(String?) onsave,
    TextInputType? keyboardtype,
    required Function(String?) validateFunction}) {
  final viewmodel = Provider.of<CheckoutViewModel>(context, listen: false);
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textformfeildheading(label: label, context: context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.01)),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              viewmodel.dialcodes = number.dialCode;
              viewmodel.mobile = number.phoneNumber;
            },

            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),

            inputDecoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hintvalue,
                fillColor: Colors.white,
                hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.grey)),
            ignoreBlank: false,

            autoValidateMode: AutovalidateMode.disabled,
            validator: (value) => validateFunction(value),
            selectorTextStyle: TextStyle(color: Colors.black),
            // initialValue: number,
            textFieldController: controller,
            formatInput: true,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
              viewmodel.dialcodes = number.dialCode;
              viewmodel.mobile = number.phoneNumber;
            },
          ),
        ),
      ],
    ),
  );
}

Widget dropDownTextFormFeild(
    {required TextEditingController controller,
    required BuildContext context,
    required String label,
    required String hintvalue,
    required Function(String?) onsave,
    required List<ShippingZoneLocation> codesList,
    required Function(dynamic) validateFunction}) {
  final viewmodel = Provider.of<CheckoutViewModel>(context, listen: false);

  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textformfeildheading(label: label, context: context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        InkWell(
          onTap: () {
            final sortedCodesList = [
              ...{...codesList}
            ];

            sortedCodesList.sort((a, b) {
              return a.code.toLowerCase().compareTo(b.code.toLowerCase());
            });
            sortedCodesList.forEach(
              (element) {
                print(element.code);
              },
            );

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Search a Country"),
                content: SearchableList<ShippingZoneLocation>(
                  initialList: sortedCodesList,
                  loadingWidget: CircularProgressIndicator.adaptive(),
                  onItemSelected: (element) {
                    viewmodel.changeSelectedCountry(
                        CountryParser.parse(element.code).name);
                    Navigator.pop(context);
                  },
                  builder: (ShippingZoneLocation element) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.005),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text(element.code),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                CountryParser.parse(element.code).name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  filter: (value) => sortedCodesList
                      .where((element) => CountryParser.parse(element.code)
                          .name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList(),
                  emptyWidget: SizedBox.shrink(),
                  inputDecoration: InputDecoration(
                    labelText: "Search a Country",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"),
                  ),
                ],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.01)),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: hintvalue,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.grey)),
                    controller: controller,
                    enabled: false,
                    onSaved: (newValue) => onsave(newValue),
                    validator: (value) => validateFunction(value),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textformfeildheading(
    {required String label, required BuildContext context}) {
  return Text(
    label,
    style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.w500),
  );
}

// CountryParser.parse(element.code).name

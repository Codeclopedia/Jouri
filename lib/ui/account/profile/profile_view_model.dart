import 'package:flutter/material.dart';

import '../../../models/customer.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/general.dart';
import '../../../utilities/http_requests.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel() {
    loadUser();
  }

  var customer;
  var firstName, lastName, email;
  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool editable = false;

  loadUser() async {
    var data = await General.getUser();
    if (data != null) {
      customer = Customer.fromJson(data);
      print('user name is : ${customer.firstName}');
      fillValues();
    } else {
      print('user is null');
    }
  }

  fillValues() {
    firstNameController.text = customer!.firstName!;
    lastNameController.text = customer!.lastName!;
    phoneNumberController.text = customer!.username!;
    emailController.text = customer!.email!;
    notifyListeners();
  }

  changeEditable() {
    editable = true;
    notifyListeners();
  }

  cancelEditions() {
    editable = false;
    notifyListeners();
  }

  Future<Customer?>? saveChanges(context) async {
    if (formKey.currentState!.validate()) {
      firstName = firstNameController.text;
      lastName = lastNameController.text;
      email = emailController.text;
      var url = Constants.baseUrl +
          Constants.customer +
          '/${customer!.id}' +
          Constants.wooAuth;
      HttpRequests.httpPutRequest(
          context: context,
          url: url,
          headers: {},
          body: {
            "first_name": firstName,
            "last_name": lastName,
            "email": email
          },
          success: (value) {
            print(value);
            var customerData = Customer.fromJson(value);
            General.saveUser(customerData.toJson());
            cancelEditions();
          },
          error: () {});
    }
  }
}

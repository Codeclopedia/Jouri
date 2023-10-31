import 'dart:convert';
import 'dart:io';

// import 'package:Jouri/models/customer.dart';
import 'package:Jouri/models/checkout_models/user_detail_model.dart';
import 'package:Jouri/models/order.dart';
import 'package:Jouri/models/payment_method.dart';
import 'package:Jouri/models/checkout_models/shipping_method.dart';
import 'package:Jouri/models/checkout_models/shipping_zone.dart';
import 'package:Jouri/models/checkout_models/shipping_zone_location.dart';
import 'package:Jouri/ui/checkout/order_complete.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:Jouri/utilities/constants.dart';
import 'package:Jouri/utilities/general.dart';
import 'package:Jouri/utilities/http_requests.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart' as tab;
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../../models/product_variation.dart';

class CheckoutViewModel extends ChangeNotifier {
  var paymentMethods = <PaymentMethod>[];
  PaymentMethod? selectedPaymentMethod;
  int selectedOrderDetailTab = 0;

  bool showfetchedUserDetails = true;

  var shippingZone = <ShippingZone>[];
  int? selectedShippingZone;

  var userDetails = <UserDetail>[];
  UserDetail? selectedUserDetails;

  var shippingZoneLocations = <ShippingZoneLocation>[];
  var selectedShippingZoneLocation;

  Customer? customer;

  var shippingMethods = <ShippingMethod>[];
  var selectedShippingMethod;

  var scrollController = ScrollController();

  List<ShippingZoneLocation> countryCodeList = <ShippingZoneLocation>[];

  var firstname, lastname, email, mobile, address, city, postal, dialcodes;

  var firstnameController = TextEditingController(),
      lastnameController = TextEditingController(),
      emailController = TextEditingController(),
      mobileController = TextEditingController(),
      countryController = TextEditingController(),
      addressController = TextEditingController(),
      cityController = TextEditingController(),
      postalController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  changeSelectedDetailTab(int value) {
    selectedOrderDetailTab = value;
    notifyListeners();
  }

  changeshowfetchedUserDetail(bool value) {
    showfetchedUserDetails = value;
    notifyListeners();
  }

  changeSelectedUserdetail(UserDetail value) {
    selectedUserDetails = value;
    notifyListeners();
  }

  changeSelectedCountry(String country) {
    countryController.text = country;
    notifyListeners();
  }

  Future<List<ShippingZoneLocation>> loadAllShippingZoneLocations(
      BuildContext context) async {
    final zones = await loadShippingZones(context);
    countryCodeList = [];
    zones.forEach((element) async {
      print(element.toJson());
      final countryCodes = await loadShippingZonesLocation(context, element.id);
      countryCodeList.addAll(countryCodes);
    });
    return countryCodeList;
  }

  Future<List<PaymentMethod>> loadPaymentMethods(context) async {
    if (paymentMethods.isNotEmpty) return paymentMethods;
    var url = Constants.baseUrl + Constants.paymentMethod + Constants.wooAuth;
    await HttpRequests.httpGetRequest(
      context: context,
      url: url,
      headers: {},
      success: (value, _) {
        paymentMethods = [];
        final List data = json.decode(value);
        paymentMethods.addAll(
          List.from(
            data.map(
              (e) => PaymentMethod.fromMap(e),
            ),
          ),
        );
      },
      error: () {},
    );
    paymentMethods.removeWhere((element) => !element.enabled);
    return paymentMethods;
  }

  Future<List<ShippingZone>> loadShippingZones(context) async {
    shippingZone.clear();
    var url = Constants.baseUrl + Constants.shippingZone + Constants.wooAuth;
    await HttpRequests.httpGetRequest(
      context: context,
      url: url,
      headers: {},
      success: (value, _) {
        List data = json.decode(value);
        shippingZone.addAll(
          List.from(
            data.map(
              (e) => ShippingZone.fromMap(e),
            ),
          ),
        );
      },
      error: () {},
    );
    return shippingZone;
  }

  Future<List<ShippingZoneLocation>> loadShippingZonesLocation(
      context, zoneId) async {
    shippingZoneLocations.clear();
    var url =
        Constants.baseUrl + Constants.shippingZoneLocation + Constants.wooAuth;
    url = url.replaceFirst('{id}', '$zoneId');
    await HttpRequests.httpGetRequest(
      context: context,
      url: url,
      headers: {},
      success: (value, _) {
        List data = json.decode(value);
        shippingZoneLocations.addAll(
          List.from(
            data.map(
              (e) => ShippingZoneLocation.fromMap(e),
            ),
          ),
        );
      },
      error: () {},
    );
    if (shippingZoneLocations.length == 1)
      selectedShippingZoneLocation = shippingZoneLocations.first.code;
    return shippingZoneLocations;
  }

  Future<List<ShippingMethod>> loadShippingMethods(context, zoneId) async {
    shippingMethods.clear();
    var url = Constants.baseUrl + Constants.shippingMethod + Constants.wooAuth;
    url = url.replaceAll('{id}', '$zoneId');
    await HttpRequests.httpGetRequest(
      context: context,
      url: url,
      headers: {},
      success: (value, _) {
        List data = json.decode(value);
        shippingMethods.addAll(
          List.from(
            data.map(
              (e) => ShippingMethod.fromMap(e),
            ),
          ),
        );
      },
      error: () {},
    );
    var method = shippingMethods.firstWhere(
      (element) => element.methodId == 'free_shipping',
      orElse: () {
        return ShippingMethod(id: -1);
      },
    );
    if (method.id != -1) {
      var minAmount = double.parse(method.settings?.minAmount?.value ?? '0');
      var totalCart = General.getCartPrice(context);
      if (totalCart <
          minAmount *
              Provider.of<NavMenuViewModel>(context, listen: false)
                  .selectedCurrency
                  .rate!) {
        shippingMethods.remove(method);
      }
    }
    if (shippingMethods.length == 1) {
      selectedShippingMethod = shippingMethods.first.id;
    } else {
      var freeShipping = shippingMethods.firstWhere(
        (element) => element.methodId == 'free_shipping',
        orElse: () {
          return ShippingMethod(id: -1);
        },
      );
      if (freeShipping.id != -1) {
        selectedShippingMethod = freeShipping.id;
        shippingMethods.removeWhere((element) => element.id != freeShipping.id);
      }
    }
    return shippingMethods;
  }

  void changeShippingZone(id) {
    selectedShippingZone = id;
    shippingMethods.clear();
    shippingZoneLocations.clear();
    selectedShippingZoneLocation = null;
    selectedShippingMethod = null;
    notifyListeners();
  }

  void changeShippingZoneV2(int id) {
    selectedShippingZone = id;

    notifyListeners();
  }

  void changeShippingZoneLocation(code) {
    selectedShippingZoneLocation = code;
    // notifyListeners();
  }

  void changeShippingMethod(value) {
    selectedShippingMethod = value;
    notifyListeners();
  }

  void changePaymentMethod(PaymentMethod value) {
    selectedPaymentMethod = value;
    notifyListeners();
  }

  void addOrder(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (checkOptions(context)) {
        formKey.currentState!.save();
        if (selectedPaymentMethod?.id == 'tap') {
          var order = await _proceedOrder(context, isFinalOrder: false);
          var lang = await General.getLanguage(context);
          _configureApp(lang);
          await _setupSDKSession(order, context);
          _startTabPayment(context, order);
        } else
          await _proceedOrder(context, status: 'on-hold');
      }
    }
  }

  void addOrder2(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (checkOptions(context)) {
        formKey.currentState!.save();
        if (selectedPaymentMethod?.id == 'tap') {
          var order = await _proceedOrder(context, isFinalOrder: false);
          var lang = await General.getLanguage(context);
          _configureApp(lang);
          await _setupSDKSession(order, context);
          _startTabPayment(context, order);
        } else
          await _proceedOrder(context, status: 'on-hold');
      }
    } else {
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.error(
      //     message: "Please Fill all the details",
      //   ),
      // );
    }
  }

  Future<List<ShippingZoneLocation>> getShippingCountries(
      BuildContext context) async {
    final zones = await loadShippingZones(context);
    final List<ShippingZoneLocation> countryCodeList = [];
    zones.forEach((element) async {
      final countryCodes = await loadShippingZonesLocation(context, element.id);
      countryCodeList.addAll(countryCodes);
    });
    print(countryCodeList);
    return countryCodeList;
  }

  bool checkOptions(BuildContext context) {
    if (selectedPaymentMethod == null) {
      print("inside 1");
      General.showErrorDialog(
        context,
        '${General.getTranslatedText(context, 'errors.paymentMethod')}',
      );
      return false;
    }
    // if (selectedShippingMethod == null) {
    //   print("inside 2");
    //   General.showErrorDialog(
    //     context,
    //     '${General.getTranslatedText(context, 'checkout.shippingMethod')}',
    //   );
    //   return false;
    // }
    if (selectedShippingZone == null) {
      print("inside 3");
      General.showErrorDialog(
        context,
        '${General.getTranslatedText(context, 'errors.addressDetails')}',
      );
      return false;
    }
    return true;
  }

  void fillData(Customer? customer) {
    if (customer != null) {
      this.customer = customer;
      firstnameController.text = customer.firstName ?? '';
      lastnameController.text = customer.lastName ?? '';
      emailController.text = customer.email ?? '';
      mobileController.text = customer.shipping?.phone ?? '';
      postalController.text = customer.shipping?.postcode ?? '';
      addressController.text = customer.shipping?.address1 ?? '';
      cityController.text = customer.shipping?.city ?? '';
    }
  }

  Future<Order> _proceedOrder(BuildContext context,
      {status, bool isFinalOrder = true}) async {
    Ing info = Ing(
      address1: address,
      city: city,
      email: email,
      firstName: firstname,
      lastName: lastname,
      phone: dialcodes + mobile,
      postcode: postal,
    );
    var url = Constants.baseUrl + Constants.orders + Constants.wooAuth;
    General.showProgress(context);
    var shipping = shippingMethods
        .firstWhere((element) => element.id == selectedShippingMethod);
    var lineItems = <LineItem>[];
    var cart = General.getCartItems();
    lineItems.addAll(
      cart.map(
        (e) {
          ProductVariation? selectedVariation = e.productDetails;
          return LineItem(
            quantity: e.quantity,
            productId: e.productId,
            variationId: selectedVariation?.id,
          );
        },
      ),
    );
    print(
        "selected currency inside  ${Provider.of<NavMenuViewModel>(context, listen: false).selectedCurrency.currency?.toUpperCase()}");
    var order = Order(
        billing: info,
        shipping: info,
        currencySymbol: Provider.of<NavMenuViewModel>(context, listen: false)
            .selectedCurrency
            .symbol,
        paymentMethod: selectedPaymentMethod?.id,
        total: General()
            .selectedCurrencyPrice(
                price: General.getCartPrice(context).toString(),
                rate: Provider.of<NavMenuViewModel>(context, listen: false)
                        .selectedCurrency
                        .rate ??
                    1.0)
            .toStringAsFixed(2),
        shippingLines: [
          ShippingLine(
              instanceId: '${shipping.instanceId}',
              methodId: '${shipping.methodId}',
              methodTitle: '${shipping.methodTitle}',
              total: '${shipping.settings?.cost?.value}'),
        ],
        shippingTotal: shipping.settings?.cost?.value,
        lineItems: lineItems,
        customerId: customer?.id,
        status: status);

    await HttpRequests.httpPostRequest(
      context: context,
      url: url,
      headers: {},
      body: General.removeNulls(order.toMap()),
      success: (value) async {
        print("inside process order 1");
        order = Order.fromJson(value);
        if (customer != null) {
          var url = Constants.baseUrl +
              Constants.customer +
              '/${customer!.id}' +
              Constants.wooAuth;
          customer!.billing = info;
          customer!.shipping = info;
          HttpRequests.httpPutRequest(
            context: context,
            url: url,
            headers: {},
            body: General.removeNulls(customer!.toMap()),
            success: (value) {
              customer = Customer.fromJson(value);
              General.saveUser(customer!.toJson());
            },
            error: () {},
          );
        }
        General.dismissProgress();
        if (isFinalOrder) {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => OrderComplete(order: order),
            ),
          );
        }
      },
      error: () {},
    );
    return order;
  }

  void _configureApp(String lang) {
    ///Android Tokens
    //Live token sk_live_6R23OPHC5wuYUKXkcsgnMNJG
    // Test token sk_test_dZJqg6vxMDrm0S3YPNwA12EB
    ///iOS Tokens
    //Live token sk_live_GcSWwXTEVu9mkz8PsD5joBOy
    // Test token sk_test_ukJ9Y14ZVicx8CbqhvrID0FQ

    GoSellSdkFlutter.configureApp(
        bundleId:
            Platform.isAndroid ? "com.jourikw.Jouri" : "com.jourikw.store",
        productionSecreteKey: Platform.isAndroid
            ? "sk_test_dZJqg6vxMDrm0S3YPNwA12EB"
            : "sk_test_ukJ9Y14ZVicx8CbqhvrID0FQ",
        sandBoxsecretKey: '',
        lang: lang);
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<void> _setupSDKSession(Order order, BuildContext context) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
        trxMode: TransactionMode.PURCHASE,
        shippings: [],
        taxes: [],

        allowsToSaveSameCardMoreThanOnce: false,
        applePayMerchantID: '',
        paymentDescription: '',
        paymentMetaData: {},
        paymentReference: tab.Reference(order: '${order.id}'),
        postURL:
            '${Constants.baseUrl}/wc-api/tap_webhook?order_id=${order.id}&hashcd=${generateMd5('${'${order.id}${General().selectedCurrencyPrice(price: General.getCartPrice(context).toStringAsFixed(2), rate: Provider.of<NavMenuViewModel>(context, listen: false).selectedCurrency.rate ?? 1.0)}${Provider.of<NavMenuViewModel>(context, listen: false).selectedCurrency.currency ?? 'KWD'}'}')}',
        allowsToEditCardHolderName: true,

        transactionCurrency:
            "${Provider.of<NavMenuViewModel>(context, listen: false).selectedCurrency.currency ?? 'KWD'}",
        amount: '${double.parse(order.total ?? '0').toStringAsFixed(2)}',
        customer: tab.Customer(
            customerId: '',
            email: customer?.email ?? 'info@jorikw.com',
            firstName: customer?.firstName ?? 'Jourikw',
            lastName: customer?.lastName ?? 'jouri',
            isdNumber: '',
            middleName: '',
            number: customer?.shipping?.phone ?? ''),
        paymentItems: [],
        paymentStatementDescriptor: "paymentStatementDescriptor",
        // Save Card Switch
        isUserAllowedToSaveCard: true,
        cardHolderName: '',
        // Enable/Disable 3DSecure
        isRequires3DSecure: true,
        // Receipt SMS/Email
        receipt: tab.Receipt(true, true),
        // Authorize Action [Capture - Void]
        authorizeAction: tab.AuthorizeAction(
            type: tab.AuthorizeActionType.CAPTURE, timeInHours: 10),
        merchantID: '',
        // Allowed cards
        allowedCadTypes: tab.CardType.ALL,
        paymentType: PaymentType.ALL,
        sdkMode: SDKMode.Production,
      );
    } on PlatformException {}
  }

  void _startTabPayment(BuildContext context, Order order) async {
    var tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;

    print('My result: $tapSDKResult');
    print('My result: ${tapSDKResult['sdk_result']}');
    switch (tapSDKResult['sdk_result']) {
      case "SUCCESS":
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => OrderComplete(order: order),
          ),
        );
        break;
      case "FAILED":
        General.showErrorDialog(context, tapSDKResult['message']);
        _orderFailed(context, order);
        break;
      case "CANCELLED":
        _deleteOrder(context, order);
        break;
      case "SDK_ERROR":
        General.showErrorDialog(context, tapSDKResult['sdk_error_description']);
        _orderFailed(context, order);
        break;
      case "NOT_IMPLEMENTED":
        General.showErrorDialog(context, tapSDKResult['message']);
        _orderFailed(context, order);
        break;
    }
    await GoSellSdkFlutter.terminateSession();
  }

  void _deleteOrder(BuildContext context, Order order) async {
    var url = Constants.baseUrl +
        Constants.orders +
        '/${order.id}' +
        Constants.wooAuth +
        '&force=true';
    await HttpRequests.httpDeleteRequest(
      context: context,
      url: url,
      headers: {},
      body: {},
      success: (value) {},
      error: () {},
    );
  }

  void _orderFailed(BuildContext context, Order order) async {
    var url = Constants.baseUrl +
        Constants.orders +
        '/${order.id}' +
        Constants.wooAuth;
    order.status = 'failed';
    await HttpRequests.httpPutRequest(
      context: context,
      url: url,
      headers: {},
      body: General.removeNulls(order.toMap()),
      success: (value) {},
      error: () {},
    );
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:Jouri/models/currency_data_response.dart';
import 'package:Jouri/ui/nav_menu/nav_menu_view_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_progress_dialog.dart';
import '../models/product.dart';

class General {
  // static ArsProgressDialog _progressDialog;
  static CustomProgressDialog? _dialog;

  static Future<String?> getStringSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getString(key);
    return data;
  }

  static Map<String, dynamic> removeNullsFromMap(Map<String, dynamic> json) =>
      json
        ..removeWhere((String key, dynamic value) => value == null)
        ..map<String, dynamic>(
            (key, value) => MapEntry(key, removeNulls(value)));

  static List removeNullsFromList(List list) => list
    ..removeWhere((value) => value == null)
    ..map((e) => removeNulls(e)).toList();

  static removeNulls(e) => (e is List)
      ? removeNullsFromList(e)
      : (e is Map<String, dynamic> ? removeNullsFromMap(e) : e);

  static Future<bool> searchInSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.containsKey(key);
    return data;
  }

  static void saveSettings(String data) {
    setStringSP('settings', data);
  }

  static String getTranslatedText(context, key,
      {Map<String, dynamic>? params}) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);

    return localizations.translate(key, params: params);
  }

  static TextDirection getTextDir(context) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);
    return localizations.textDirection;
  }

  static void changeLanguage(context, langKey) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);
    localizations.setLocale(Locale(langKey));
    print("new language $langKey");
    General.setStringSP('lang', '$langKey');
  }

  static String getLanguage(context) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);
    print(localizations.locale.languageCode);
    return localizations.locale.languageCode;
  }

  static Future<String?> getSettings() async {
    return await getStringSP('settings');
  }

  static showProgress(context, {color = Colors.black38}) {
    _dialog = CustomProgressDialog(context: context, isDismissible: false);
    _dialog?.show();
  }

  static void saveUser(String data) {
    setStringSP('user', data);
  }

  static dismissProgress() {
    _dialog?.hide();
  }

  static Future<String?> getUser() async {
    return await getStringSP('user');
  }

  static showErrorDialog(context, message) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: getTranslatedText(context, 'config.error'),
        desc: General.getTranslatedText(context, '$message'),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkText: getTranslatedText(context, 'config.ok'),
        btnOkColor: Theme.of(context).primaryColor)
      ..show();
  }

  static showInfoDialog(context, message, yesText, noText, yesFunction) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: false,
        title: getTranslatedText(context, 'config.warning'),
        desc: '$message',
        btnOkOnPress: yesFunction,
        btnOkText: getTranslatedText(context, '$yesText'),
        btnOkColor: Theme.of(context).primaryColor,
        btnCancelOnPress: () {},
        btnCancelText: getTranslatedText(context, '$noText'),
        btnCancelColor: Theme.of(context).colorScheme.secondary)
      ..show();
  }

  static showSuccessDialog(context, title, user) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: false,
      title: '$title',
      desc: '',
      btnOkOnPress: () async {},
      btnOkText: getTranslatedText(context, 'config.ok'),
      btnOkColor: Theme.of(context).primaryColor,
    )..show();
  }

  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      //arabic to english
      input = input.replaceAll(arabic[i], english[i]);
      //English to Arabic
      // input = input.replaceAll(english[i],arabic[i]);
    }
    return input;
  }

  static CurrencyData getCurrency(
    context,
  ) {
    final instanceOfprovider =
        Provider.of<NavMenuViewModel>(context, listen: false);
    final selectCurrency = instanceOfprovider.selectedCurrency;
    print("selected currency ${selectCurrency.toJson()}");

    return selectCurrency;
  }

  static launchURL(url) async {
    url = Uri.encodeFull(url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Error launching $url';
    }
  }

  double selectedCurrencyPrice({required String? price, required double rate}) {
    return double.parse(
            price?.trim().isNotEmpty ?? false ? price ?? '1.0' : '1.0') *
        rate;
  }

  static Future<bool> checkUserAvailability() async {
    if (await getUser() != null) return true;
    return false;
  }

  static Future<bool> checkVersion(String storeVersion) async {
    if (storeVersion.isEmpty) {
      return false;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    List<String> store = storeVersion.split(".");
    List<String> current = currentVersion.split(".");
    print('storeVersion: $storeVersion');
    print('currentVersion: $currentVersion');
    try {
      // To avoid IndexOutOfBounds
      int maxIndex = min(store.length, current.length);
      for (int i = 0; i < maxIndex; i++) {
        int n1 = int.parse(store[i]);
        int n2 = int.parse(current[i]);
        if (n1 > n2) {
          return true;
        } else if (n2 > n1) {
          return false;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> getBooleanSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getBool(key);
    data ??= false;
    return data;
  }

  static Future<int?> getIntSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getInt(key);
    return data;
  }

  static void setStringSP(String key, String data) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(key, data);
  }

  static void clearSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(key);
  }

  static void setIntSP(String key, int data) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(key, data);
  }

  static void setBooleanSP(String key, bool data) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(key, data);
  }

  /// cart methods

  static FlutterCart? _cart;
  static final _box = GetStorage();

  static Set<Product> getFav() {
    Set<Product> items = {};
    if (_box.hasData('fav')) {
      var data = json.decode(_box.read('fav'));
      data.forEach((element) {
        items.add(Product.fromJson(element));
        print(element);
      });
    }
    return items;
  }

  static void addToFav(product) {
    Set<Product> favProducts = getFav();
    favProducts.add(product);
    var set = favProducts.map((e) => e.toJson()).toList();
    var data = jsonEncode(set);
    _box.write('fav', data);
    print(' ${product.id} added to fav');
  }

  static void removeFromFav(product) async {
    Set<Product> favProducts = getFav();
    favProducts.removeWhere((element) => element.id == product.id);
    var set = favProducts.map((e) => e.toJson()).toList();
    var data = jsonEncode(set);
    _box.write('fav', data);
    print(' ${product.id} removed from fav');
  }

  static void initCart() async {
    _cart = FlutterCart();

    if (_box.hasData('cart')) {
      List<CartItem> items = [];
      List data = json.decode(_box.read('cart'));
      data.forEach((element) {
        var item = CartItem.fromJson(element);
        items.add(item);
        addToCart(
            productId: item.productId,
            unitPrice: item.unitPrice,
            quantity: item.quantity,
            variation: item.productDetails);
      });
    }
  }

  static void addToCart(
      {required productId,
      required unitPrice,
      required quantity,
      variation}) async {
    if (_cart == null) initCart();

    var item = _cart!.getSpecificItemFromCart(productId);

    if (item == null) {
      var message = _cart?.addToCart(
          productId: productId,
          unitPrice: unitPrice,
          quantity: quantity,
          productDetailsObject: variation);
      print(message.message);
    } else {
      incrementCartItem(productId: productId);
    }
    _box.write('cart', json.encode(_cart!.cartItem));
  }

  static void updateCart(
      {required productId, required unitPrice, variation}) async {
    if (_cart == null) initCart();
    var quantity = getSpecificCart(productId: productId)!.quantity;
    removeCartItem(productId: productId);
    addToCart(
        productId: productId,
        unitPrice: unitPrice,
        quantity: quantity,
        variation: variation);
  }

  static void incrementCartItem({required productId}) async {
    if (_cart == null) initCart();
    var index = _cart!.findItemIndexFromCart(productId);
    if (index != null) {
      var message = _cart!.incrementItemToCart(index);
      print(message.message);
    }
    _box.write('cart', json.encode(_cart!.cartItem));
  }

  static void decrementCartItem({required productId}) async {
    if (_cart == null) initCart();
    var index = _cart!.findItemIndexFromCart(productId);
    if (index != null) {
      var message = _cart!.decrementItemFromCart(index);
      print(message.message);
    }
    _box.write('cart', json.encode(_cart!.cartItem));
  }

  static void clearCart() async {
    if (_cart == null) initCart();
    _cart!.deleteAllCart();
    _box.remove('cart');
  }

  static void removeCartItem({required productId}) async {
    if (_cart == null) initCart();
    var index = _cart!.findItemIndexFromCart(productId);
    if (index != null) {
      var message = _cart!.deleteItemFromCart(index);
      print(message.message);
    }
    _box.write('cart', json.encode(_cart!.cartItem));
  }

  static int getCartCount() {
    if (_cart == null) initCart();
    int count = _cart!.getCartItemCount();
    return count;
  }

  static double getCartPrice(BuildContext context) {
    if (_cart == null) initCart();
    var price = _cart!.getTotalAmount();
    print("total of cart $price");
    price = double.parse(price.toString());
    return price *
            Provider.of<NavMenuViewModel>(context, listen: false)
                .selectedCurrency
                .rate ??
        1.0;
  }

  static List<int> getCartIds() {
    if (_cart == null) initCart();
    var ids = <int>[];
    var list = _cart!.cartItem;
    list.forEach((element) {
      ids.add(element.productId);
    });
    return ids;
  }

  static List<CartItem> getCartItems() {
    if (_cart == null) initCart();
    var list = _cart!.cartItem;
    return list;
  }

  static CartItem? getSpecificCart({required productId}) {
    if (_cart == null) initCart();
    var item = _cart!.getSpecificItemFromCart(productId);
    return item;
  }

  ///

  static void setFavSP(data) async {
    final sp = await SharedPreferences.getInstance();
    var stringData;
    if (data is Set) {
      stringData = json.encode(data.toList());
    } else {
      stringData = json.encode(data);
    }
    await sp.setString('fav', stringData);
  }

  static Future<String?> getFavSP() async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getString('fav');
    return data;
  }

  static final countryList = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas (the)",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Botswana",
    "Bouvet Island",
    "Brazil",
    "Brunei Darussalam",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cabo Verde",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Chad",
    "Chile",
    "China",
    "Christmas Island",
    "Colombia",
    "Comoros (the)",
    "Congo",
    "Congo (the)",
    "Cook Islands (the)",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Curaçao",
    "Cyprus",
    "Czechia",
    "Côte d'Ivoire",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic (the)",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Holy See",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea",
    "Kuwait",
    "Kyrgyzstan",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macao",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands (the)",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger (the)",
    "Nigeria",
    "Niue",
    "Norfolk Island",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine, State of",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines (the)",
    "Pitcairn",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Republic of North Macedonia",
    "Romania",
    "Russian Federation (the)",
    "Rwanda",
    "Réunion",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Sint Maarten (Dutch part)",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan (the)",
    "Suriname",
    "Svalbard and Jan Mayen",
    "Sweden",
    "Switzerland",
    "Syrian Arab Republic",
    "Taiwan",
    "Tajikistan",
  ];
}

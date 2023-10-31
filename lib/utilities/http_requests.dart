import 'dart:convert';
import 'dart:io';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'general.dart';

class HttpRequests {
  static httpGetRequest(
      {required context,
      required url,
      required Map<String, String> headers,
      required Function(String, Map<String, String>) success,
      required Function error}) async {
    print(url);
    // if (await General.getStringSP('token') != null) {
    //   headers[HttpHeaders.authorizationHeader] =
    //       'Bearer ${await General.getStringSP('token')}';
    // }
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    headers[HttpHeaders.connectionHeader] = 'keep-alive';
    headers[HttpHeaders.authorizationHeader] =
        'Basic aGtrdWp3dGFuZzp3NFl5Z2dnR0tm';
    print(headers);
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      print('result: ${response.body}');
      print('result header: ${response.headers}');
      success(response.body, response.headers);
    } else {
      General.dismissProgress();
      print(response.body);
      // if (!kDebugMode) {
      //   var crash = FirebaseCrashlytics.instance;
      //   crash.setCustomKey('getError', response.body);
      // }
      print(response.body);
      var data = json.decode(response.body);
      General.showErrorDialog(context, data['message']);
      error();
    }
  }

  static httpPostRequest({
    required context,
    required url,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required Function(String) success,
    required void Function() error,
  }) async {
    print('POST Request: ' + url);
    print('POST Body: ${json.encode(body)}');
    // if (await General.getStringSP('token') != null)
    //   headers[HttpHeaders.authorizationHeader] =
    //       '${await General.getStringSP('token')}';
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.authorizationHeader] =
        'Basic aGtrdWp3dGFuZzp3NFl5Z2dnR0tm';
    print(headers);
    var response = await http.post(Uri.parse(url),
        body: json.encode(body), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      success(response.body);
    } else {
      General.dismissProgress();
      print(response.body);
      // if (!kDebugMode) {
      //   var crash = FirebaseCrashlytics.instance;
      //   crash.setCustomKey('addError', response.body);
      // }
      var data = json.decode(response.body);
      error();
      General.showErrorDialog(context, data['message']);
    }
  }

  static httpPutRequest(
      {required context,
      required url,
      required Map<String, String> headers,
      required Map<String, dynamic> body,
      required Function(String) success,
      required Function error}) async {
    print(url);
    // if (await General.getStringSP('token') != null) {
    //   headers[HttpHeaders.authorizationHeader] =
    //       'Bearer ${await General.getStringSP('token')}';
    // }
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.authorizationHeader] =
        'Basic aGtrdWp3dGFuZzp3NFl5Z2dnR0tm';
    print(headers);
    var response = await http.put(Uri.parse(url),
        body: json.encode(body), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      success(response.body);
    } else {
      General.dismissProgress();
      print(response.statusCode);
      print(response.body);
      // if (!kDebugMode) {
      //   var crash = FirebaseCrashlytics.instance;
      //   crash.setCustomKey('updateError', response.body);
      // }
      var data = json.decode(response.body);
      General.showErrorDialog(context, data['message']);
      error();
    }
  }

  static httpDeleteRequest(
      {required context,
      required url,
      required Map<String, String> headers,
      required Map<String, dynamic> body,
      required Function(String) success,
      required Function error}) async {
    print(url);
    // if (await General.getStringSP('token') != null) {
    //   headers[HttpHeaders.authorizationHeader] =
    //       'Bearer ${await General.getStringSP('token')}';
    // }
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.authorizationHeader] =
        'Basic aGtrdWp3dGFuZzp3NFl5Z2dnR0tm';
    print(headers);
    var response = await http.delete(Uri.parse(url),
        body: json.encode(body), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      success(response.body);
    } else {
      General.dismissProgress();
      print(response.statusCode);
      print(response.body);
      // if (!kDebugMode) {
      //   var crash = FirebaseCrashlytics.instance;
      //   crash.setCustomKey('updateError', response.body);
      // }
      var data = json.decode(response.body);
      General.showErrorDialog(context, data['message']);
      error();
    }
  }
}

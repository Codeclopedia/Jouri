// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

List<UserDetail> userDetailFromJson(String str) =>
    List<UserDetail>.from(json.decode(str).map((x) => UserDetail.fromJson(x)));

String userDetailToJson(List<UserDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetail {
  String? firstname;
  String? lastname;
  String? email;
  String? mobile;

  UserDetail({
    this.firstname,
    this.lastname,
    this.email,
    this.mobile,
  });

  factory UserDetail.fromRawJson(String str) =>
      UserDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "mobile": mobile,
      };
}

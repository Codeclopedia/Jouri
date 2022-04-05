// To parse this JSON data, do
//
//     final customer = customerFromMap(jsonString);

import 'dart:convert';

class Customer {
  Customer({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,
    this.metaData,
    this.links,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  Ing? billing;
  Ing? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;
  List<MetaDatum>? metaData;
  Links? links;

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        role: json["role"] == null ? null : json["role"],
        username: json["username"] == null ? null : json["username"],
        billing: json["billing"] == null ? null : Ing.fromMap(json["billing"]),
        shipping:
            json["shipping"] == null ? null : Ing.fromMap(json["shipping"]),
        isPayingCustomer: json["is_paying_customer"] == null
            ? null
            : json["is_paying_customer"],
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        metaData: json["meta_data"] == null
            ? null
            : List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromMap(x))),
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "date_created":
            dateCreated == null ? null : dateCreated!.toIso8601String(),
        "date_created_gmt":
            dateCreatedGmt == null ? null : dateCreatedGmt!.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified!.toIso8601String(),
        "date_modified_gmt":
            dateModifiedGmt == null ? null : dateModifiedGmt!.toIso8601String(),
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "role": role == null ? null : role,
        "username": username == null ? null : username,
        "billing": billing == null ? null : billing!.toMap(),
        "shipping": shipping == null ? null : shipping!.toMap(),
        "is_paying_customer":
            isPayingCustomer == null ? null : isPayingCustomer,
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toMap())),
        "_links": links == null ? null : links!.toMap(),
      };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  String? country;
  String? state;
  String? email;
  String? phone;

  factory Ing.fromJson(String str) => Ing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ing.fromMap(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        company: json["company"] == null ? null : json["company"],
        address1: json["address_1"] == null ? null : json["address_1"],
        address2: json["address_2"] == null ? null : json["address_2"],
        city: json["city"] == null ? null : json["city"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "company": company == null ? null : company,
        "address_1": address1 == null ? null : address1,
        "address_2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "postcode": postcode == null ? null : postcode,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<Collection>.from(
                json["self"].map((x) => Collection.fromMap(x))),
        collection: json["collection"] == null
            ? null
            : List<Collection>.from(
                json["collection"].map((x) => Collection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toMap())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toMap())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(String str) =>
      Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href == null ? null : href,
      };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  dynamic? value;

  factory MetaDatum.fromJson(String str) => MetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaDatum.fromMap(Map<String, dynamic> json) => MetaDatum(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "value": value,
      };
}

class ValueClass {
  ValueClass({
    this.expires,
    this.products,
  });

  int? expires;
  List<dynamic>? products;

  factory ValueClass.fromJson(String str) =>
      ValueClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ValueClass.fromMap(Map<String, dynamic> json) => ValueClass(
        expires: json["expires"] == null ? null : json["expires"],
        products: json["products"] == null
            ? null
            : List<dynamic>.from(json["products"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "expires": expires == null ? null : expires,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x)),
      };
}

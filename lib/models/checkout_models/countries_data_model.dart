// To parse this JSON data, do
//
//     final countriesData = countriesDataFromJson(jsonString);

import 'dart:convert';

class CountriesData {
  String? code;
  String? type;
  Links? links;

  CountriesData({
    this.code,
    this.type,
    this.links,
  });

  factory CountriesData.fromRawJson(String str) =>
      CountriesData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountriesData.fromJson(Map<String, dynamic> json) => CountriesData(
        code: json["code"],
        type: json["type"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
        "_links": links?.toJson(),
      };
}

class Links {
  List<Collection>? collection;
  List<Collection>? describes;

  Links({
    this.collection,
    this.describes,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        describes: List<Collection>.from(
            json["describes"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collection":
            List<dynamic>.from(collection?.map((x) => x.toJson()) ?? []),
        "describes":
            List<dynamic>.from(describes?.map((x) => x.toJson()) ?? []),
      };
}

class Collection {
  String? href;

  Collection({
    this.href,
  });

  factory Collection.fromRawJson(String str) =>
      Collection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

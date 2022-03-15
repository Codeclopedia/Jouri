// To parse this JSON data, do
//
//     final attributeTerm = attributeTermFromMap(jsonString);

import 'dart:convert';

class AttributeTerm {
  AttributeTerm({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.menuOrder,
    this.count,
    this.links,
  });

  int? id;
  String? name;
  String? slug;
  String? description;
  int? menuOrder;
  int? count;
  Links? links;

  factory AttributeTerm.fromJson(String str) =>
      AttributeTerm.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttributeTerm.fromMap(Map<String, dynamic> json) => AttributeTerm(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        description: json["description"] == null ? null : json["description"],
        menuOrder: json["menu_order"] == null ? null : json["menu_order"],
        count: json["count"] == null ? null : json["count"],
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "description": description == null ? null : description,
        "menu_order": menuOrder == null ? null : menuOrder,
        "count": count == null ? null : count,
        "_links": links == null ? null : links!.toMap(),
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

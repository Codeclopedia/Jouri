// To parse this JSON data, do
//
//     final mobileBanner = mobileBannerFromMap(jsonString);

import 'dart:convert';

class MobileBanner {
  MobileBanner({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.featuredMedia,
    this.template,
    this.acf,
    this.links,
  });

  int? id;
  DateTime? date;
  DateTime? dateGmt;
  Guid? guid;
  DateTime? modified;
  DateTime? modifiedGmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  Guid? title;
  FeaturedMedia? featuredMedia;
  String? template;
  List<dynamic>? acf;
  Links? links;

  factory MobileBanner.fromJson(String str) =>
      MobileBanner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MobileBanner.fromMap(Map<String, dynamic> json) => MobileBanner(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dateGmt:
            json["date_gmt"] == null ? null : DateTime.parse(json["date_gmt"]),
        guid: json["guid"] == null ? null : Guid.fromMap(json["guid"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedGmt: json["modified_gmt"] == null
            ? null
            : DateTime.parse(json["modified_gmt"]),
        slug: json["slug"] == null ? null : json["slug"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : Guid.fromMap(json["title"]),
        featuredMedia: json["featured_media"] == null
            ? null
            : FeaturedMedia.fromMap(json["featured_media"]),
        template: json["template"] == null ? null : json["template"],
        acf: json["acf"] == null
            ? null
            : List<dynamic>.from(json["acf"].map((x) => x)),
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date!.toIso8601String(),
        "date_gmt": dateGmt == null ? null : dateGmt!.toIso8601String(),
        "guid": guid == null ? null : guid!.toMap(),
        "modified": modified == null ? null : modified!.toIso8601String(),
        "modified_gmt":
            modifiedGmt == null ? null : modifiedGmt!.toIso8601String(),
        "slug": slug == null ? null : slug,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "title": title == null ? null : title!.toMap(),
        "featured_media": featuredMedia == null ? null : featuredMedia!.toMap(),
        "template": template == null ? null : template,
        "acf": acf == null ? null : List<dynamic>.from(acf!.map((x) => x)),
        "_links": links == null ? null : links!.toMap(),
      };
}

class FeaturedMedia {
  FeaturedMedia({
    this.medium,
    this.large,
  });

  String? medium;
  String? large;

  factory FeaturedMedia.fromJson(String str) =>
      FeaturedMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeaturedMedia.fromMap(Map<String, dynamic> json) => FeaturedMedia(
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
      );

  Map<String, dynamic> toMap() => {
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
      };
}

class Guid {
  Guid({
    this.rendered,
  });

  String? rendered;

  factory Guid.fromJson(String str) => Guid.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Guid.fromMap(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"] == null ? null : json["rendered"],
      );

  Map<String, dynamic> toMap() => {
        "rendered": rendered == null ? null : rendered,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.about,
    this.wpFeaturedmedia,
    this.wpAttachment,
    this.curies,
  });

  List<About>? self;
  List<About>? collection;
  List<About>? about;
  List<WpFeaturedmedia>? wpFeaturedmedia;
  List<About>? wpAttachment;
  List<Cury>? curies;

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<About>.from(json["self"].map((x) => About.fromMap(x))),
        collection: json["collection"] == null
            ? null
            : List<About>.from(json["collection"].map((x) => About.fromMap(x))),
        about: json["about"] == null
            ? null
            : List<About>.from(json["about"].map((x) => About.fromMap(x))),
        wpFeaturedmedia: json["wp:featuredmedia"] == null
            ? null
            : List<WpFeaturedmedia>.from(json["wp:featuredmedia"]
                .map((x) => WpFeaturedmedia.fromMap(x))),
        wpAttachment: json["wp:attachment"] == null
            ? null
            : List<About>.from(
                json["wp:attachment"].map((x) => About.fromMap(x))),
        curies: json["curies"] == null
            ? null
            : List<Cury>.from(json["curies"].map((x) => Cury.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toMap())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toMap())),
        "about": about == null
            ? null
            : List<dynamic>.from(about!.map((x) => x.toMap())),
        "wp:featuredmedia": wpFeaturedmedia == null
            ? null
            : List<dynamic>.from(wpFeaturedmedia!.map((x) => x.toMap())),
        "wp:attachment": wpAttachment == null
            ? null
            : List<dynamic>.from(wpAttachment!.map((x) => x.toMap())),
        "curies": curies == null
            ? null
            : List<dynamic>.from(curies!.map((x) => x.toMap())),
      };
}

class About {
  About({
    this.href,
  });

  String? href;

  factory About.fromJson(String str) => About.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory About.fromMap(Map<String, dynamic> json) => About(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href == null ? null : href,
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  String? name;
  String? href;
  bool? templated;

  factory Cury.fromJson(String str) => Cury.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cury.fromMap(Map<String, dynamic> json) => Cury(
        name: json["name"] == null ? null : json["name"],
        href: json["href"] == null ? null : json["href"],
        templated: json["templated"] == null ? null : json["templated"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "href": href == null ? null : href,
        "templated": templated == null ? null : templated,
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.embeddable,
    this.href,
  });

  bool? embeddable;
  String? href;

  factory WpFeaturedmedia.fromJson(String str) =>
      WpFeaturedmedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WpFeaturedmedia.fromMap(Map<String, dynamic> json) => WpFeaturedmedia(
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toMap() => {
        "embeddable": embeddable == null ? null : embeddable,
        "href": href == null ? null : href,
      };
}

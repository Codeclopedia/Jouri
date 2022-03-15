// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.lowStockAmount,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.priceHtml,
    this.relatedIds,
    this.metaData,
    this.stockStatus,
    this.isPurchased,
    this.attributesData,
    this.links,
  });

  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  List<dynamic>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  dynamic stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  dynamic lowStockAmount;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Category>? categories;
  List<Category>? tags;
  List<Images>? images;
  List<Attribute>? attributes;
  List<dynamic>? defaultAttributes;
  List<dynamic>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  List<MetaDatum>? metaData;
  String? stockStatus;
  bool? isPurchased;
  List<AttributesDatum>? attributesData;
  Links? links;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        permalink: json["permalink"] == null ? null : json["permalink"],
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
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        featured: json["featured"] == null ? null : json["featured"],
        catalogVisibility: json["catalog_visibility"] == null
            ? null
            : json["catalog_visibility"],
        description: json["description"] == null ? null : json["description"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        sku: json["sku"] == null ? null : json["sku"],
        price: json["price"] == null ? null : json["price"],
        regularPrice:
            json["regular_price"] == null ? null : json["regular_price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"] == null ? null : json["on_sale"],
        purchasable: json["purchasable"] == null ? null : json["purchasable"],
        totalSales: json["total_sales"] == null ? null : json["total_sales"],
        virtual: json["virtual"] == null ? null : json["virtual"],
        downloadable:
            json["downloadable"] == null ? null : json["downloadable"],
        downloads: json["downloads"] == null
            ? null
            : List<dynamic>.from(json["downloads"].map((x) => x)),
        downloadLimit:
            json["download_limit"] == null ? null : json["download_limit"],
        downloadExpiry:
            json["download_expiry"] == null ? null : json["download_expiry"],
        externalUrl: json["external_url"] == null ? null : json["external_url"],
        buttonText: json["button_text"] == null ? null : json["button_text"],
        taxStatus: json["tax_status"] == null ? null : json["tax_status"],
        taxClass: json["tax_class"] == null ? null : json["tax_class"],
        manageStock: json["manage_stock"] == null ? null : json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        backorders: json["backorders"] == null ? null : json["backorders"],
        backordersAllowed: json["backorders_allowed"] == null
            ? null
            : json["backorders_allowed"],
        backordered: json["backordered"] == null ? null : json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        soldIndividually: json["sold_individually"] == null
            ? null
            : json["sold_individually"],
        weight: json["weight"] == null ? null : json["weight"],
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromMap(json["dimensions"]),
        shippingRequired: json["shipping_required"] == null
            ? null
            : json["shipping_required"],
        shippingTaxable:
            json["shipping_taxable"] == null ? null : json["shipping_taxable"],
        shippingClass:
            json["shipping_class"] == null ? null : json["shipping_class"],
        shippingClassId: json["shipping_class_id"] == null
            ? null
            : json["shipping_class_id"],
        reviewsAllowed:
            json["reviews_allowed"] == null ? null : json["reviews_allowed"],
        averageRating:
            json["average_rating"] == null ? null : json["average_rating"],
        ratingCount: json["rating_count"] == null ? null : json["rating_count"],
        upsellIds: json["upsell_ids"] == null
            ? null
            : List<dynamic>.from(json["upsell_ids"].map((x) => x)),
        crossSellIds: json["cross_sell_ids"] == null
            ? null
            : List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        purchaseNote:
            json["purchase_note"] == null ? null : json["purchase_note"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromMap(x))),
        tags: json["tags"] == null
            ? null
            : List<Category>.from(json["tags"].map((x) => Category.fromMap(x))),
        images: json["images"] == null
            ? null
            : List<Images>.from(json["images"].map((x) => Images.fromMap(x))),
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromMap(x))),
        defaultAttributes: json["default_attributes"] == null
            ? null
            : List<dynamic>.from(json["default_attributes"].map((x) => x)),
        variations: json["variations"] == null
            ? null
            : List<dynamic>.from(json["variations"].map((x) => x)),
        groupedProducts: json["grouped_products"] == null
            ? null
            : List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"] == null ? null : json["menu_order"],
        priceHtml: json["price_html"] == null ? null : json["price_html"],
        relatedIds: json["related_ids"] == null
            ? null
            : List<int>.from(json["related_ids"].map((x) => x)),
        metaData: json["meta_data"] == null
            ? null
            : List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromMap(x))),
        stockStatus: json["stock_status"] == null ? null : json["stock_status"],
        isPurchased: json["is_purchased"] == null ? null : json["is_purchased"],
        attributesData: json["attributesData"] == null
            ? null
            : List<AttributesDatum>.from(
                json["attributesData"].map((x) => AttributesDatum.fromMap(x))),
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "permalink": permalink == null ? null : permalink,
        "date_created":
            dateCreated == null ? null : dateCreated!.toIso8601String(),
        "date_created_gmt":
            dateCreatedGmt == null ? null : dateCreatedGmt!.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified!.toIso8601String(),
        "date_modified_gmt":
            dateModifiedGmt == null ? null : dateModifiedGmt!.toIso8601String(),
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "featured": featured == null ? null : featured,
        "catalog_visibility":
            catalogVisibility == null ? null : catalogVisibility,
        "description": description == null ? null : description,
        "short_description": shortDescription == null ? null : shortDescription,
        "sku": sku == null ? null : sku,
        "price": price == null ? null : price,
        "regular_price": regularPrice == null ? null : regularPrice,
        "sale_price": salePrice == null ? null : salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "on_sale": onSale == null ? null : onSale,
        "purchasable": purchasable == null ? null : purchasable,
        "total_sales": totalSales == null ? null : totalSales,
        "virtual": virtual == null ? null : virtual,
        "downloadable": downloadable == null ? null : downloadable,
        "downloads": downloads == null
            ? null
            : List<dynamic>.from(downloads!.map((x) => x)),
        "download_limit": downloadLimit == null ? null : downloadLimit,
        "download_expiry": downloadExpiry == null ? null : downloadExpiry,
        "external_url": externalUrl == null ? null : externalUrl,
        "button_text": buttonText == null ? null : buttonText,
        "tax_status": taxStatus == null ? null : taxStatus,
        "tax_class": taxClass == null ? null : taxClass,
        "manage_stock": manageStock == null ? null : manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backorders == null ? null : backorders,
        "backorders_allowed":
            backordersAllowed == null ? null : backordersAllowed,
        "backordered": backordered == null ? null : backordered,
        "low_stock_amount": lowStockAmount,
        "sold_individually": soldIndividually == null ? null : soldIndividually,
        "weight": weight == null ? null : weight,
        "dimensions": dimensions == null ? null : dimensions!.toMap(),
        "shipping_required": shippingRequired == null ? null : shippingRequired,
        "shipping_taxable": shippingTaxable == null ? null : shippingTaxable,
        "shipping_class": shippingClass == null ? null : shippingClass,
        "shipping_class_id": shippingClassId == null ? null : shippingClassId,
        "reviews_allowed": reviewsAllowed == null ? null : reviewsAllowed,
        "average_rating": averageRating == null ? null : averageRating,
        "rating_count": ratingCount == null ? null : ratingCount,
        "upsell_ids": upsellIds == null
            ? null
            : List<dynamic>.from(upsellIds!.map((x) => x)),
        "cross_sell_ids": crossSellIds == null
            ? null
            : List<dynamic>.from(crossSellIds!.map((x) => x)),
        "parent_id": parentId == null ? null : parentId,
        "purchase_note": purchaseNote == null ? null : purchaseNote,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toMap())),
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags!.map((x) => x.toMap())),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toMap())),
        "default_attributes": defaultAttributes == null
            ? null
            : List<dynamic>.from(defaultAttributes!.map((x) => x)),
        "variations": variations == null
            ? null
            : List<dynamic>.from(variations!.map((x) => x)),
        "grouped_products": groupedProducts == null
            ? null
            : List<dynamic>.from(groupedProducts!.map((x) => x)),
        "menu_order": menuOrder == null ? null : menuOrder,
        "price_html": priceHtml == null ? null : priceHtml,
        "related_ids": relatedIds == null
            ? null
            : List<dynamic>.from(relatedIds!.map((x) => x)),
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toMap())),
        "stock_status": stockStatus == null ? null : stockStatus,
        "is_purchased": isPurchased == null ? null : isPurchased,
        "attributesData": attributesData == null
            ? null
            : List<dynamic>.from(attributesData!.map((x) => x.toMap())),
        "_links": links == null ? null : links!.toMap(),
      };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  factory Attribute.fromJson(String str) => Attribute.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attribute.fromMap(Map<String, dynamic> json) => Attribute(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        position: json["position"] == null ? null : json["position"],
        visible: json["visible"] == null ? null : json["visible"],
        variation: json["variation"] == null ? null : json["variation"],
        options: json["options"] == null
            ? null
            : List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "position": position == null ? null : position,
        "visible": visible == null ? null : visible,
        "variation": variation == null ? null : variation,
        "options":
            options == null ? null : List<dynamic>.from(options!.map((x) => x)),
      };
}

class AttributesDatum {
  AttributesDatum({
    this.id,
    this.name,
    this.options,
    this.position,
    this.visible,
    this.variation,
    this.isVisible,
    this.isVariation,
    this.isTaxonomy,
    this.value,
    this.label,
  });

  int? id;
  String? name;
  List<Option>? options;
  int? position;
  bool? visible;
  bool? variation;
  int? isVisible;
  int? isVariation;
  int? isTaxonomy;
  String? value;
  String? label;

  factory AttributesDatum.fromJson(String str) =>
      AttributesDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttributesDatum.fromMap(Map<String, dynamic> json) => AttributesDatum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
        position: json["position"] == null ? null : json["position"],
        visible: json["visible"] == null ? null : json["visible"],
        variation: json["variation"] == null ? null : json["variation"],
        isVisible: json["is_visible"] == null ? null : json["is_visible"],
        isVariation: json["is_variation"] == null ? null : json["is_variation"],
        isTaxonomy: json["is_taxonomy"] == null ? null : json["is_taxonomy"],
        value: json["value"] == null ? null : json["value"],
        label: json["label"] == null ? null : json["label"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toMap())),
        "position": position == null ? null : position,
        "visible": visible == null ? null : visible,
        "variation": variation == null ? null : variation,
        "is_visible": isVisible == null ? null : isVisible,
        "is_variation": isVariation == null ? null : isVariation,
        "is_taxonomy": isTaxonomy == null ? null : isTaxonomy,
        "value": value == null ? null : value,
        "label": label == null ? null : label,
      };
}

class Option {
  Option({
    this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.filter,
  });

  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
        termId: json["term_id"] == null ? null : json["term_id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        termGroup: json["term_group"] == null ? null : json["term_group"],
        termTaxonomyId:
            json["term_taxonomy_id"] == null ? null : json["term_taxonomy_id"],
        taxonomy: json["taxonomy"] == null ? null : json["taxonomy"],
        description: json["description"] == null ? null : json["description"],
        parent: json["parent"] == null ? null : json["parent"],
        count: json["count"] == null ? null : json["count"],
        filter: json["filter"] == null ? null : json["filter"],
      );

  Map<String, dynamic> toMap() => {
        "term_id": termId == null ? null : termId,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "term_group": termGroup == null ? null : termGroup,
        "term_taxonomy_id": termTaxonomyId == null ? null : termTaxonomyId,
        "taxonomy": taxonomy == null ? null : taxonomy,
        "description": description == null ? null : description,
        "parent": parent == null ? null : parent,
        "count": count == null ? null : count,
        "filter": filter == null ? null : filter,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
      };
}

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  String? length;
  String? width;
  String? height;

  factory Dimensions.fromJson(String str) =>
      Dimensions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dimensions.fromMap(Map<String, dynamic> json) => Dimensions(
        length: json["length"] == null ? null : json["length"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
      );

  Map<String, dynamic> toMap() => {
        "length": length == null ? null : length,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
      };
}

class Images {
  Images({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
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
        src: json["src"] == null ? null : json["src"],
        name: json["name"] == null ? null : json["name"],
        alt: json["alt"] == null ? null : json["alt"],
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
        "src": src == null ? null : src,
        "name": name == null ? null : name,
        "alt": alt == null ? null : alt,
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
  dynamic value;

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
    this.wdTextBlock,
    this.column,
    this.wdImageOrSvg,
    this.section,
  });

  WdTextBlock? wdTextBlock;
  Columns? column;
  WdImageOrSvg? wdImageOrSvg;
  Section? section;

  factory ValueClass.fromJson(String str) =>
      ValueClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ValueClass.fromMap(Map<String, dynamic> json) => ValueClass(
        wdTextBlock: json["wd_text_block"] == null
            ? null
            : WdTextBlock.fromMap(json["wd_text_block"]),
        column: json["column"] == null ? null : Columns.fromMap(json["column"]),
        wdImageOrSvg: json["wd_image_or_svg"] == null
            ? null
            : WdImageOrSvg.fromMap(json["wd_image_or_svg"]),
        section:
            json["section"] == null ? null : Section.fromMap(json["section"]),
      );

  Map<String, dynamic> toMap() => {
        "wd_text_block": wdTextBlock == null ? null : wdTextBlock!.toMap(),
        "column": column == null ? null : column!.toMap(),
        "wd_image_or_svg": wdImageOrSvg == null ? null : wdImageOrSvg!.toMap(),
        "section": section == null ? null : section!.toMap(),
      };
}

class Columns {
  Columns({
    this.count,
    this.controlPercent,
    this.controls,
  });

  int? count;
  int? controlPercent;
  ColumnControls? controls;

  factory Columns.fromJson(String str) => Columns.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Columns.fromMap(Map<String, dynamic> json) => Columns(
        count: json["count"] == null ? null : json["count"],
        controlPercent:
            json["control_percent"] == null ? null : json["control_percent"],
        controls: json["controls"] == null
            ? null
            : ColumnControls.fromMap(json["controls"]),
      );

  Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        "control_percent": controlPercent == null ? null : controlPercent,
        "controls": controls == null ? null : controls!.toMap(),
      };
}

class ColumnControls {
  ColumnControls({
    this.layout,
  });

  PurpleLayout? layout;

  factory ColumnControls.fromJson(String str) =>
      ColumnControls.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ColumnControls.fromMap(Map<String, dynamic> json) => ColumnControls(
        layout: json["layout"] == null
            ? null
            : PurpleLayout.fromMap(json["layout"]),
      );

  Map<String, dynamic> toMap() => {
        "layout": layout == null ? null : layout!.toMap(),
      };
}

class PurpleLayout {
  PurpleLayout({
    this.layout,
  });

  LayoutLayout? layout;

  factory PurpleLayout.fromJson(String str) =>
      PurpleLayout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurpleLayout.fromMap(Map<String, dynamic> json) => PurpleLayout(
        layout: json["layout"] == null
            ? null
            : LayoutLayout.fromMap(json["layout"]),
      );

  Map<String, dynamic> toMap() => {
        "layout": layout == null ? null : layout!.toMap(),
      };
}

class LayoutLayout {
  LayoutLayout({
    this.inlineSize,
  });

  int? inlineSize;

  factory LayoutLayout.fromJson(String str) =>
      LayoutLayout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LayoutLayout.fromMap(Map<String, dynamic> json) => LayoutLayout(
        inlineSize: json["_inline_size"] == null ? null : json["_inline_size"],
      );

  Map<String, dynamic> toMap() => {
        "_inline_size": inlineSize == null ? null : inlineSize,
      };
}

class Section {
  Section({
    this.count,
    this.controlPercent,
    this.controls,
  });

  int? count;
  int? controlPercent;
  SectionControls? controls;

  factory Section.fromJson(String str) => Section.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Section.fromMap(Map<String, dynamic> json) => Section(
        count: json["count"] == null ? null : json["count"],
        controlPercent:
            json["control_percent"] == null ? null : json["control_percent"],
        controls: json["controls"] == null
            ? null
            : SectionControls.fromMap(json["controls"]),
      );

  Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        "control_percent": controlPercent == null ? null : controlPercent,
        "controls": controls == null ? null : controls!.toMap(),
      };
}

class SectionControls {
  SectionControls({
    this.layout,
  });

  FluffyLayout? layout;

  factory SectionControls.fromJson(String str) =>
      SectionControls.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SectionControls.fromMap(Map<String, dynamic> json) => SectionControls(
        layout: json["layout"] == null
            ? null
            : FluffyLayout.fromMap(json["layout"]),
      );

  Map<String, dynamic> toMap() => {
        "layout": layout == null ? null : layout!.toMap(),
      };
}

class FluffyLayout {
  FluffyLayout({
    this.sectionStructure,
  });

  SectionStructure? sectionStructure;

  factory FluffyLayout.fromJson(String str) =>
      FluffyLayout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluffyLayout.fromMap(Map<String, dynamic> json) => FluffyLayout(
        sectionStructure: json["section_structure"] == null
            ? null
            : SectionStructure.fromMap(json["section_structure"]),
      );

  Map<String, dynamic> toMap() => {
        "section_structure":
            sectionStructure == null ? null : sectionStructure!.toMap(),
      };
}

class SectionStructure {
  SectionStructure({
    this.structure,
  });

  int? structure;

  factory SectionStructure.fromJson(String str) =>
      SectionStructure.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SectionStructure.fromMap(Map<String, dynamic> json) =>
      SectionStructure(
        structure: json["structure"] == null ? null : json["structure"],
      );

  Map<String, dynamic> toMap() => {
        "structure": structure == null ? null : structure,
      };
}

class WdImageOrSvg {
  WdImageOrSvg({
    this.count,
    this.controlPercent,
    this.controls,
  });

  int? count;
  int? controlPercent;
  WdImageOrSvgControls? controls;

  factory WdImageOrSvg.fromJson(String str) =>
      WdImageOrSvg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WdImageOrSvg.fromMap(Map<String, dynamic> json) => WdImageOrSvg(
        count: json["count"] == null ? null : json["count"],
        controlPercent:
            json["control_percent"] == null ? null : json["control_percent"],
        controls: json["controls"] == null
            ? null
            : WdImageOrSvgControls.fromMap(json["controls"]),
      );

  Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        "control_percent": controlPercent == null ? null : controlPercent,
        "controls": controls == null ? null : controls!.toMap(),
      };
}

class WdImageOrSvgControls {
  WdImageOrSvgControls({
    this.content,
  });

  PurpleContent? content;

  factory WdImageOrSvgControls.fromJson(String str) =>
      WdImageOrSvgControls.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WdImageOrSvgControls.fromMap(Map<String, dynamic> json) =>
      WdImageOrSvgControls(
        content: json["content"] == null
            ? null
            : PurpleContent.fromMap(json["content"]),
      );

  Map<String, dynamic> toMap() => {
        "content": content == null ? null : content!.toMap(),
      };
}

class PurpleContent {
  PurpleContent({
    this.generalContentSection,
  });

  PurpleGeneralContentSection? generalContentSection;

  factory PurpleContent.fromJson(String str) =>
      PurpleContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurpleContent.fromMap(Map<String, dynamic> json) => PurpleContent(
        generalContentSection: json["general_content_section"] == null
            ? null
            : PurpleGeneralContentSection.fromMap(
                json["general_content_section"]),
      );

  Map<String, dynamic> toMap() => {
        "general_content_section": generalContentSection == null
            ? null
            : generalContentSection!.toMap(),
      };
}

class PurpleGeneralContentSection {
  PurpleGeneralContentSection({
    this.image,
    this.imageSize,
  });

  int? image;
  int? imageSize;

  factory PurpleGeneralContentSection.fromJson(String str) =>
      PurpleGeneralContentSection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurpleGeneralContentSection.fromMap(Map<String, dynamic> json) =>
      PurpleGeneralContentSection(
        image: json["image"] == null ? null : json["image"],
        imageSize: json["image_size"] == null ? null : json["image_size"],
      );

  Map<String, dynamic> toMap() => {
        "image": image == null ? null : image,
        "image_size": imageSize == null ? null : imageSize,
      };
}

class WdTextBlock {
  WdTextBlock({
    this.count,
    this.controlPercent,
    this.controls,
  });

  int? count;
  int? controlPercent;
  WdTextBlockControls? controls;

  factory WdTextBlock.fromJson(String str) =>
      WdTextBlock.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WdTextBlock.fromMap(Map<String, dynamic> json) => WdTextBlock(
        count: json["count"] == null ? null : json["count"],
        controlPercent:
            json["control_percent"] == null ? null : json["control_percent"],
        controls: json["controls"] == null
            ? null
            : WdTextBlockControls.fromMap(json["controls"]),
      );

  Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        "control_percent": controlPercent == null ? null : controlPercent,
        "controls": controls == null ? null : controls!.toMap(),
      };
}

class WdTextBlockControls {
  WdTextBlockControls({
    this.content,
  });

  FluffyContent? content;

  factory WdTextBlockControls.fromJson(String str) =>
      WdTextBlockControls.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WdTextBlockControls.fromMap(Map<String, dynamic> json) =>
      WdTextBlockControls(
        content: json["content"] == null
            ? null
            : FluffyContent.fromMap(json["content"]),
      );

  Map<String, dynamic> toMap() => {
        "content": content == null ? null : content!.toMap(),
      };
}

class FluffyContent {
  FluffyContent({
    this.generalContentSection,
  });

  FluffyGeneralContentSection? generalContentSection;

  factory FluffyContent.fromJson(String str) =>
      FluffyContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluffyContent.fromMap(Map<String, dynamic> json) => FluffyContent(
        generalContentSection: json["general_content_section"] == null
            ? null
            : FluffyGeneralContentSection.fromMap(
                json["general_content_section"]),
      );

  Map<String, dynamic> toMap() => {
        "general_content_section": generalContentSection == null
            ? null
            : generalContentSection!.toMap(),
      };
}

class FluffyGeneralContentSection {
  FluffyGeneralContentSection({
    this.text,
  });

  int? text;

  factory FluffyGeneralContentSection.fromJson(String str) =>
      FluffyGeneralContentSection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluffyGeneralContentSection.fromMap(Map<String, dynamic> json) =>
      FluffyGeneralContentSection(
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toMap() => {
        "text": text == null ? null : text,
      };
}

// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'dart:convert';

class Order {
  Order({
    this.id,
    this.parentId,
    this.status,
    this.currency,
    this.version,
    this.pricesIncludeTax,
    this.dateCreated,
    this.dateModified,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.customerId,
    this.orderKey,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.createdVia,
    this.customerNote,
    this.dateCompleted,
    this.datePaid,
    this.cartHash,
    this.number,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.dateCreatedGmt,
    this.dateModifiedGmt,
    this.dateCompletedGmt,
    this.datePaidGmt,
    this.currencySymbol,
    this.links,
  });

  int? id;
  int? parentId;
  String? status;
  String? currency;
  String? version;
  bool? pricesIncludeTax;
  DateTime? dateCreated;
  DateTime? dateModified;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  int? customerId;
  String? orderKey;
  Ing? billing;
  Ing? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? createdVia;
  String? customerNote;
  dynamic dateCompleted;
  dynamic datePaid;
  String? cartHash;
  String? number;
  List<ProductDataMetaDatum>? metaData;
  List<LineItem>? lineItems;
  List<dynamic>? taxLines;
  List<ShippingLine>? shippingLines;
  List<dynamic>? feeLines;
  List<dynamic>? couponLines;
  List<dynamic>? refunds;
  DateTime? dateCreatedGmt;
  DateTime? dateModifiedGmt;
  dynamic dateCompletedGmt;
  dynamic datePaidGmt;
  String? currencySymbol;
  Links? links;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        status: json["status"] == null ? null : json["status"],
        currency: json["currency"] == null ? null : json["currency"],
        version: json["version"] == null ? null : json["version"],
        pricesIncludeTax: json["prices_include_tax"] == null
            ? null
            : json["prices_include_tax"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        discountTotal:
            json["discount_total"] == null ? null : json["discount_total"],
        discountTax: json["discount_tax"] == null ? null : json["discount_tax"],
        shippingTotal:
            json["shipping_total"] == null ? null : json["shipping_total"],
        shippingTax: json["shipping_tax"] == null ? null : json["shipping_tax"],
        cartTax: json["cart_tax"] == null ? null : json["cart_tax"],
        total: json["total"] == null ? null : json["total"],
        totalTax: json["total_tax"] == null ? null : json["total_tax"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        orderKey: json["order_key"] == null ? null : json["order_key"],
        billing: json["billing"] == null ? null : Ing.fromMap(json["billing"]),
        shipping:
            json["shipping"] == null ? null : Ing.fromMap(json["shipping"]),
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        paymentMethodTitle: json["payment_method_title"] == null
            ? null
            : json["payment_method_title"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        customerIpAddress: json["customer_ip_address"] == null
            ? null
            : json["customer_ip_address"],
        customerUserAgent: json["customer_user_agent"] == null
            ? null
            : json["customer_user_agent"],
        createdVia: json["created_via"] == null ? null : json["created_via"],
        customerNote:
            json["customer_note"] == null ? null : json["customer_note"],
        dateCompleted: json["date_completed"],
        datePaid: json["date_paid"],
        cartHash: json["cart_hash"] == null ? null : json["cart_hash"],
        number: json["number"] == null ? null : json["number"],
        metaData: json["meta_data"] == null
            ? null
            : List<ProductDataMetaDatum>.from(
                json["meta_data"].map((x) => ProductDataMetaDatum.fromMap(x))),
        lineItems: json["line_items"] == null
            ? null
            : List<LineItem>.from(
                json["line_items"].map((x) => LineItem.fromMap(x))),
        taxLines: json["tax_lines"] == null
            ? null
            : List<dynamic>.from(json["tax_lines"].map((x) => x)),
        shippingLines: json["shipping_lines"] == null
            ? null
            : List<ShippingLine>.from(
                json["shipping_lines"].map((x) => ShippingLine.fromMap(x))),
        feeLines: json["fee_lines"] == null
            ? null
            : List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: json["coupon_lines"] == null
            ? null
            : List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        refunds: json["refunds"] == null
            ? null
            : List<dynamic>.from(json["refunds"].map((x) => x)),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        dateCompletedGmt: json["date_completed_gmt"],
        datePaidGmt: json["date_paid_gmt"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "parent_id": parentId == null ? null : parentId,
        "status": status == null ? null : status,
        "currency": currency == null ? null : currency,
        "version": version == null ? null : version,
        "prices_include_tax":
            pricesIncludeTax == null ? null : pricesIncludeTax,
        "date_created":
            dateCreated == null ? null : dateCreated!.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified!.toIso8601String(),
        "discount_total": discountTotal == null ? null : discountTotal,
        "discount_tax": discountTax == null ? null : discountTax,
        "shipping_total": shippingTotal == null ? null : shippingTotal,
        "shipping_tax": shippingTax == null ? null : shippingTax,
        "cart_tax": cartTax == null ? null : cartTax,
        "total": total == null ? null : total,
        "total_tax": totalTax == null ? null : totalTax,
        "customer_id": customerId == null ? null : customerId,
        "order_key": orderKey == null ? null : orderKey,
        "billing": billing == null ? null : billing!.toMap(),
        "shipping": shipping == null ? null : shipping!.toMap(),
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "payment_method_title":
            paymentMethodTitle == null ? null : paymentMethodTitle,
        "transaction_id": transactionId == null ? null : transactionId,
        "customer_ip_address":
            customerIpAddress == null ? null : customerIpAddress,
        "customer_user_agent":
            customerUserAgent == null ? null : customerUserAgent,
        "created_via": createdVia == null ? null : createdVia,
        "customer_note": customerNote == null ? null : customerNote,
        "date_completed": dateCompleted,
        "date_paid": datePaid,
        "cart_hash": cartHash == null ? null : cartHash,
        "number": number == null ? null : number,
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toMap())),
        "line_items": lineItems == null
            ? null
            : List<dynamic>.from(lineItems!.map((x) => x.toMap())),
        "tax_lines": taxLines == null
            ? null
            : List<dynamic>.from(taxLines!.map((x) => x)),
        "shipping_lines": shippingLines == null
            ? null
            : List<dynamic>.from(shippingLines!.map((x) => x.toMap())),
        "fee_lines": feeLines == null
            ? null
            : List<dynamic>.from(feeLines!.map((x) => x)),
        "coupon_lines": couponLines == null
            ? null
            : List<dynamic>.from(couponLines!.map((x) => x)),
        "refunds":
            refunds == null ? null : List<dynamic>.from(refunds!.map((x) => x)),
        "date_created_gmt":
            dateCreatedGmt == null ? null : dateCreatedGmt!.toIso8601String(),
        "date_modified_gmt":
            dateModifiedGmt == null ? null : dateModifiedGmt!.toIso8601String(),
        "date_completed_gmt": dateCompletedGmt,
        "date_paid_gmt": datePaidGmt,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
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
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
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
        state: json["state"] == null ? null : json["state"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        country: json["country"] == null ? null : json["country"],
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
        "state": state == null ? null : state,
        "postcode": postcode == null ? null : postcode,
        "country": country == null ? null : country,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
      };
}

class LineItem {
  LineItem({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
    this.sku,
    this.price,
    this.parentName,
    this.productData,
  });

  int? id;
  String? name;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  List<dynamic>? taxes;
  List<LineItemMetaDatum>? metaData;
  String? sku;
  int? price;
  String? parentName;
  ProductData? productData;

  factory LineItem.fromJson(String str) => LineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItem.fromMap(Map<String, dynamic> json) => LineItem(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        productId: json["product_id"] == null ? null : json["product_id"],
        variationId: json["variation_id"] == null ? null : json["variation_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        taxClass: json["tax_class"] == null ? null : json["tax_class"],
        subtotal: json["subtotal"] == null ? null : json["subtotal"],
        subtotalTax: json["subtotal_tax"] == null ? null : json["subtotal_tax"],
        total: json["total"] == null ? null : json["total"],
        totalTax: json["total_tax"] == null ? null : json["total_tax"],
        taxes: json["taxes"] == null
            ? null
            : List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: json["meta_data"] == null
            ? null
            : List<LineItemMetaDatum>.from(
                json["meta_data"].map((x) => LineItemMetaDatum.fromMap(x))),
        sku: json["sku"] == null ? null : json["sku"],
        price: json["price"] == null ? null : json["price"],
        parentName: json["parent_name"] == null ? null : json["parent_name"],
        productData: json["product_data"] == null
            ? null
            : ProductData.fromMap(json["product_data"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "product_id": productId == null ? null : productId,
        "variation_id": variationId == null ? null : variationId,
        "quantity": quantity == null ? null : quantity,
        "tax_class": taxClass == null ? null : taxClass,
        "subtotal": subtotal == null ? null : subtotal,
        "subtotal_tax": subtotalTax == null ? null : subtotalTax,
        "total": total == null ? null : total,
        "total_tax": totalTax == null ? null : totalTax,
        "taxes": taxes == null ? null : List<dynamic>.from(taxes!.map((x) => x)),
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toMap())),
        "sku": sku == null ? null : sku,
        "price": price == null ? null : price,
        "parent_name": parentName == null ? null : parentName,
        "product_data": productData == null ? null : productData!.toMap(),
      };
}

class LineItemMetaDatum {
  LineItemMetaDatum({
    this.id,
    this.key,
    this.value,
    this.displayKey,
    this.displayValue,
  });

  int? id;
  String? key;
  String? value;
  String? displayKey;
  String? displayValue;

  factory LineItemMetaDatum.fromJson(String str) =>
      LineItemMetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItemMetaDatum.fromMap(Map<String, dynamic> json) =>
      LineItemMetaDatum(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
        displayKey: json["display_key"] == null ? null : json["display_key"],
        displayValue:
            json["display_value"] == null ? null : json["display_value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "value": value == null ? null : value,
        "display_key": displayKey == null ? null : displayKey,
        "display_value": displayValue == null ? null : displayValue,
      };
}

class ProductData {
  ProductData({
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
    this.minPrice,
    this.maxPrice,
    this.variationProducts,
    this.attributesData,
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
  int? stockQuantity;
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
  List<Image>? images;
  List<Attribute>? attributes;
  List<dynamic>? defaultAttributes;
  List<int>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  List<ProductDataMetaDatum>? metaData;
  String? stockStatus;
  bool? isPurchased;
  String? minPrice;
  String? maxPrice;
  List<VariationProduct>? variationProducts;
  List<AttributesDatum>? attributesData;

  factory ProductData.fromJson(String str) =>
      ProductData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductData.fromMap(Map<String, dynamic> json) => ProductData(
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
        stockQuantity:
            json["stock_quantity"] == null ? null : json["stock_quantity"],
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
            : List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromMap(x))),
        defaultAttributes: json["default_attributes"] == null
            ? null
            : List<dynamic>.from(json["default_attributes"].map((x) => x)),
        variations: json["variations"] == null
            ? null
            : List<int>.from(json["variations"].map((x) => x)),
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
            : List<ProductDataMetaDatum>.from(
                json["meta_data"].map((x) => ProductDataMetaDatum.fromMap(x))),
        stockStatus: json["stock_status"] == null ? null : json["stock_status"],
        isPurchased: json["is_purchased"] == null ? null : json["is_purchased"],
        minPrice: json["min_price"] == null ? null : json["min_price"],
        maxPrice: json["max_price"] == null ? null : json["max_price"],
        variationProducts: json["variation_products"] == null
            ? null
            : List<VariationProduct>.from(json["variation_products"]
                .map((x) => VariationProduct.fromMap(x))),
        attributesData: json["attributesData"] == null
            ? null
            : List<AttributesDatum>.from(
                json["attributesData"].map((x) => AttributesDatum.fromMap(x))),
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
        "stock_quantity": stockQuantity == null ? null : stockQuantity,
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
        "min_price": minPrice == null ? null : minPrice,
        "max_price": maxPrice == null ? null : maxPrice,
        "variation_products": variationProducts == null
            ? null
            : List<dynamic>.from(variationProducts!.map((x) => x.toMap())),
        "attributesData": attributesData == null
            ? null
            : List<dynamic>.from(attributesData!.map((x) => x.toMap())),
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

class Image {
  Image({
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

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
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

class ProductDataMetaDatum {
  ProductDataMetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  String? value;

  factory ProductDataMetaDatum.fromJson(String str) =>
      ProductDataMetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDataMetaDatum.fromMap(Map<String, dynamic> json) =>
      ProductDataMetaDatum(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}

class VariationProduct {
  VariationProduct({
    this.id,
    this.productId,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    this.onSale,
    this.inStock,
    this.stockQuantity,
    this.stockStatus,
    this.featureImage,
    this.attributesArr,
  });

  int? id;
  int? productId;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleTo;
  bool? onSale;
  bool? inStock;
  int? stockQuantity;
  String? stockStatus;
  String? featureImage;
  List<AttributesArr>? attributesArr;

  factory VariationProduct.fromJson(String str) =>
      VariationProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariationProduct.fromMap(Map<String, dynamic> json) =>
      VariationProduct(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        price: json["price"] == null ? null : json["price"],
        regularPrice:
            json["regular_price"] == null ? null : json["regular_price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleTo: json["date_on_sale_to"],
        onSale: json["on_sale"] == null ? null : json["on_sale"],
        inStock: json["in_stock"] == null ? null : json["in_stock"],
        stockQuantity:
            json["stock_quantity"] == null ? null : json["stock_quantity"],
        stockStatus: json["stock_status"] == null ? null : json["stock_status"],
        featureImage:
            json["feature_image"] == null ? null : json["feature_image"],
        attributesArr: json["attributes_arr"] == null
            ? null
            : List<AttributesArr>.from(
                json["attributes_arr"].map((x) => AttributesArr.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "price": price == null ? null : price,
        "regular_price": regularPrice == null ? null : regularPrice,
        "sale_price": salePrice == null ? null : salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_to": dateOnSaleTo,
        "on_sale": onSale == null ? null : onSale,
        "in_stock": inStock == null ? null : inStock,
        "stock_quantity": stockQuantity == null ? null : stockQuantity,
        "stock_status": stockStatus == null ? null : stockStatus,
        "feature_image": featureImage == null ? null : featureImage,
        "attributes_arr": attributesArr == null
            ? null
            : List<dynamic>.from(attributesArr!.map((x) => x.toMap())),
      };
}

class AttributesArr {
  AttributesArr({
    this.name,
    this.slug,
    this.attributeName,
  });

  String? name;
  String? slug;
  String? attributeName;

  factory AttributesArr.fromJson(String str) =>
      AttributesArr.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttributesArr.fromMap(Map<String, dynamic> json) => AttributesArr(
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        attributeName:
            json["attribute_name"] == null ? null : json["attribute_name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "attribute_name": attributeName == null ? null : attributeName,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.customer,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? customer;

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
        customer: json["customer"] == null
            ? null
            : List<Collection>.from(
                json["customer"].map((x) => Collection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toMap())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toMap())),
        "customer": customer == null
            ? null
            : List<dynamic>.from(customer!.map((x) => x.toMap())),
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

class ShippingLine {
  ShippingLine({
    this.id,
    this.methodTitle,
    this.methodId,
    this.instanceId,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
  });

  int? id;
  String? methodTitle;
  String? methodId;
  String? instanceId;
  String? total;
  String? totalTax;
  List<dynamic>? taxes;
  List<LineItemMetaDatum>? metaData;

  factory ShippingLine.fromJson(String str) =>
      ShippingLine.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingLine.fromMap(Map<String, dynamic> json) => ShippingLine(
        id: json["id"] == null ? null : json["id"],
        methodTitle: json["method_title"] == null ? null : json["method_title"],
        methodId: json["method_id"] == null ? null : json["method_id"],
        instanceId: json["instance_id"] == null ? null : json["instance_id"],
        total: json["total"] == null ? null : json["total"],
        totalTax: json["total_tax"] == null ? null : json["total_tax"],
        taxes: json["taxes"] == null
            ? null
            : List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: json["meta_data"] == null
            ? null
            : List<LineItemMetaDatum>.from(
                json["meta_data"].map((x) => LineItemMetaDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "method_title": methodTitle == null ? null : methodTitle,
        "method_id": methodId == null ? null : methodId,
        "instance_id": instanceId == null ? null : instanceId,
        "total": total == null ? null : total,
        "total_tax": totalTax == null ? null : totalTax,
        "taxes": taxes == null ? null : List<dynamic>.from(taxes!.map((x) => x)),
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toMap())),
      };
}

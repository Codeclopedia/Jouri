import 'dart:convert';

class ShippingMethod {
  ShippingMethod({
    required this.id,
    this.instanceId,
    this.title,
    this.order,
    this.enabled,
    this.methodId,
    this.methodTitle,
    this.methodDescription,
    this.settings,
  });

  int id;
  int? instanceId;
  String? title;
  int? order;
  bool? enabled;
  String? methodId;
  String? methodTitle;
  String? methodDescription;
  Settings? settings;

  factory ShippingMethod.fromJson(String str) =>
      ShippingMethod.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingMethod.fromMap(Map<String, dynamic> json) => ShippingMethod(
        id: json["id"] == null ? null : json["id"],
        instanceId: json["instance_id"] == null ? null : json["instance_id"],
        title: json["title"] == null ? null : json["title"],
        order: json["order"] == null ? null : json["order"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        methodId: json["method_id"] == null ? null : json["method_id"],
        methodTitle: json["method_title"] == null ? null : json["method_title"],
        methodDescription: json["method_description"] == null
            ? null
            : json["method_description"],
        settings: json["settings"] == null
            ? null
            : Settings.fromMap(json["settings"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "instance_id": instanceId == null ? null : instanceId,
        "title": title == null ? null : title,
        "order": order == null ? null : order,
        "enabled": enabled == null ? null : enabled,
        "method_id": methodId == null ? null : methodId,
        "method_title": methodTitle == null ? null : methodTitle,
        "method_description":
            methodDescription == null ? null : methodDescription,
        "settings": settings == null ? null : settings!.toMap(),
      };
}

class Settings {
  Settings({
    this.cost,
    this.minAmount,
  });

  Cost? cost;
  Cost? minAmount;

  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        cost: json["cost"] == null ? null : Cost.fromMap(json["cost"]),
        minAmount: json["min_amount"] == null ? null : Cost.fromMap(json["min_amount"]),
      );

  Map<String, dynamic> toMap() => {
        "cost": cost == null ? null : cost!.toMap(),
        "min_amount": minAmount == null ? null : minAmount!.toMap(),
      };
}

class Cost {
  Cost({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.costDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  String? type;
  String? value;
  String? costDefault;
  String? tip;
  String? placeholder;
  Options? options;

  factory Cost.fromJson(String str) => Cost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cost.fromMap(Map<String, dynamic> json) => Cost(
        id: json["id"] == null ? null : json["id"],
        label: json["label"] == null ? null : json["label"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        costDefault: json["default"] == null ? null : json["default"],
        tip: json["tip"] == null ? null : json["tip"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        options:
            json["options"] == null ? null : Options.fromMap(json["options"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "label": label == null ? null : label,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "default": costDefault == null ? null : costDefault,
        "tip": tip == null ? null : tip,
        "placeholder": placeholder == null ? null : placeholder,
        "options": options == null ? null : options!.toMap(),
      };
}

class Options {
  Options({
    this.taxable,
    this.none,
  });

  String? taxable;
  String? none;

  factory Options.fromJson(String str) => Options.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Options.fromMap(Map<String, dynamic> json) => Options(
        taxable: json["taxable"] == null ? null : json["taxable"],
        none: json["none"] == null ? null : json["none"],
      );

  Map<String, dynamic> toMap() => {
        "taxable": taxable == null ? null : taxable,
        "none": none == null ? null : none,
      };
}

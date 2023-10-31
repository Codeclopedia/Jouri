import 'dart:convert';

List<ShippingZoneLocation> shippingZoneLocationFromJson(String str) =>
    List<ShippingZoneLocation>.from(
        json.decode(str).map((x) => ShippingZoneLocation.fromJson(x)));

String shippingZoneLocationToJson(List<ShippingZoneLocation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippingZoneLocation {
  ShippingZoneLocation({
    required this.code,
    required this.type,
  });

  String code;
  String type;

  factory ShippingZoneLocation.fromJson(String str) =>
      ShippingZoneLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingZoneLocation.fromMap(Map<String, dynamic> json) =>
      ShippingZoneLocation(
        code: json["code"] == null ? null : json["code"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "type": type == null ? null : type,
      };
}

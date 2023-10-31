import 'dart:convert';

List<ShippingZone> shippingZoneFromJson(String str) => List<ShippingZone>.from(
    json.decode(str).map((x) => ShippingZone.fromJson(x)));

String shippingZoneToJson(List<ShippingZone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippingZone {
  ShippingZone({
    required this.id,
    required this.name,
    required this.order,
  });

  int id;
  String name;
  int order;

  factory ShippingZone.fromJson(String str) =>
      ShippingZone.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingZone.fromMap(Map<String, dynamic> json) => ShippingZone(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        order: json["order"] == null ? null : json["order"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "order": order == null ? null : order,
      };
}

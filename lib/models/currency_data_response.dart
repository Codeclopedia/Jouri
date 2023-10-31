// To parse this JSON data, do
//
//     final currencyData = currencyDataFromJson(jsonString);

import 'dart:convert';

class CurrencyData {
  String? name;
  String? country;
  double? rate;
  String? symbol;
  String? currency;

  CurrencyData({
    this.name,
    this.country,
    this.rate,
    this.symbol,
    this.currency,
  });

  factory CurrencyData.fromRawJson(String str) =>
      CurrencyData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyData.fromJson(Map<String, dynamic> json) => CurrencyData(
        name: json["name"],
        country: json["country"],
        rate: json["rate"].toDouble(),
        symbol: json["symbol"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "rate": rate,
        "symbol": symbol,
        "currency": currency,
      };
}

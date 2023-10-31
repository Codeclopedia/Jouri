import 'dart:convert';

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.title,
    this.description,
    this.order,
    required this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.needsSetup,
    this.postInstallScripts,
    this.settingsUrl,
    this.connectionUrl,
    this.setupHelpText,
    this.requiredSettingsKeys,
  });

  String? id;
  String? title;
  String? description;
  String? order;
  bool enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;
  bool? needsSetup;
  List<dynamic>? postInstallScripts;
  String? settingsUrl;
  dynamic connectionUrl;
  dynamic setupHelpText;
  List<dynamic>? requiredSettingsKeys;

  factory PaymentMethod.fromJson(String str) =>
      PaymentMethod.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromMap(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        order: json["order"] == null ? null : json["order"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        methodTitle: json["method_title"] == null ? null : json["method_title"],
        methodDescription: json["method_description"] == null
            ? null
            : json["method_description"],
        methodSupports: json["method_supports"] == null
            ? null
            : List<String>.from(json["method_supports"].map((x) => x)),
        needsSetup: json["needs_setup"] == null ? null : json["needs_setup"],
        postInstallScripts: json["post_install_scripts"] == null
            ? null
            : List<dynamic>.from(json["post_install_scripts"].map((x) => x)),
        settingsUrl: json["settings_url"] == null ? null : json["settings_url"],
        connectionUrl: json["connection_url"],
        setupHelpText: json["setup_help_text"],
        requiredSettingsKeys: json["required_settings_keys"] == null
            ? null
            : List<dynamic>.from(json["required_settings_keys"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "order": order == null ? null : order,
        "enabled": enabled == null ? null : enabled,
        "method_title": methodTitle == null ? null : methodTitle,
        "method_description":
            methodDescription == null ? null : methodDescription,
        "method_supports": methodSupports == null
            ? null
            : List<dynamic>.from(methodSupports!.map((x) => x)),
        "needs_setup": needsSetup == null ? null : needsSetup,
        "post_install_scripts": postInstallScripts == null
            ? null
            : List<dynamic>.from(postInstallScripts!.map((x) => x)),
        "settings_url": settingsUrl == null ? null : settingsUrl,
        "connection_url": connectionUrl,
        "setup_help_text": setupHelpText,
        "required_settings_keys": requiredSettingsKeys == null
            ? null
            : List<dynamic>.from(requiredSettingsKeys!.map((x) => x)),
      };
}

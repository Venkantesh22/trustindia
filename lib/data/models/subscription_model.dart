import 'package:lekra/services/constants.dart';

class SubscriptionModel {
  final int? id;
  final String? name;
  final String? price;
  final List<String>? features;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubscriptionModel({
    this.id,
    this.name,
    this.price,
    this.features,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json["id"],
        name: capitalize(json["name"]),
        price: json["price"],
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
  String get priceFormat =>
      PriceConverter.convertToNumberFormat(double.parse(price ?? "0.0"));
}

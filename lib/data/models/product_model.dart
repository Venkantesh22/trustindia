import 'dart:convert';

import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';

class ProductModel {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final double? discountedPrice;
  final List<String>? features;
  final String? offers;
  final String? offerType;
  final String? priceCategory;
  final String? categoryName;
  final String? status;
  final List<Image>? images;
  int? quantity;
  int? orderId;
  DateTime? createdAt;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discountedPrice,
    this.features,
    this.offers,
    this.offerType,
    this.priceCategory,
    this.categoryName,
    this.status,
    this.images,
    this.quantity,
    this.orderId,
    this.createdAt,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],

        // FIX 1: Handle price safely (String OR Number)
        price: json["price"] == null
            ? null
            : double.tryParse(json["price"].toString().replaceAll(',', '')),

        // FIX 2: Handle discounted_price safely
        discountedPrice: json["discounted_price"] == null
            ? null
            : double.tryParse(
                json["discounted_price"].toString().replaceAll(',', '')),

        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
        offers:
            json["offers"]?.toString(), // Safely convert to string if needed
        offerType: json["offer_type"],
        priceCategory: json["price_category"],
        // Added null check for category_name to avoid crash if null
        categoryName: json["category_name"] != null
            ? capitalize(json["category_name"])
            : null,
        status: json["status"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        quantity: json["quantity"],
        orderId: json["order_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "discounted_price": discountedPrice,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "offers": offers,
        "offer_type": offerType,
        "price_category": priceCategory,
        "status": status,
        "quantity": quantity,
        "order_id": orderId,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };

  // ✅ Formatters for display
  String get priceFormat => PriceConverter.convertToNumberFormat(price ?? 0.0);

  String get discountedPriceFormat =>
      PriceConverter.convertToNumberFormat(discountedPrice ?? price ?? 0.0);

  String get offersFormat {
    if (offers == null || offers!.isEmpty) return "";
    if (offerType == "percentage") {
      return "$offers OFF";
    } else {
      return offers ?? "";
    }
  }

  String? get orderStatus => status == "pending"
      ? Assets.imagesOrderStatusConfirmed
      : status == "processing"
          ? Assets.imagesOrderStatusConfirmed
          : status == "shipped"
              ? Assets.imagesOrderStatusShipping
              : status == "delivered"
                  ? Assets.imagesOrderStatusDelivered
                  : status == "cancelled"
                      ? Assets.imagesOrderStatusCancel
                      : null;
}

class Image {
  final int? id;
  final String? url;

  Image({
    this.id,
    this.url,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

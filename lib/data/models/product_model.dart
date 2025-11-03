import 'dart:convert';

class ProductModel {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final double? discountedPrice;
  final List<String>? features;
  final String? offers;
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
        price: json["price"] == null
            ? null
            : double.parse(json["price"].replaceAll(',', '')),
        discountedPrice: json["discounted_price"] == null
            ? null
            : double.parse(json["discounted_price"].replaceAll(',', '')),
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
        offers: json["offers"],
        priceCategory: json["price_category"],
        categoryName: json["category_name"],
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
        "price_category": priceCategory,
        "status": status,
        "quantity": quantity,
        "order_id": orderId,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };
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

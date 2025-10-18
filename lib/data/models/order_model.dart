import 'package:lekra/data/models/product_model.dart';

class OrderModel {
  int? id;
  int? addressId;
  String? totalAmount;
  String? status;
  String? billingName;
  String? billingPhone;
  String? billingEmail;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductModel>? products;

  OrderModel({
    this.id,
    this.addressId,
    this.totalAmount,
    this.status,
    this.billingName,
    this.billingPhone,
    this.billingEmail,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        addressId: json["address_id"],
        totalAmount: json["total_amount"],
        status: json["status"],
        billingName: json["billing_name"],
        billingPhone: json["billing_phone"],
        billingEmail: json["billing_email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"]!.map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_id": addressId,
        "total_amount": totalAmount,
        "status": status,
        "billing_name": billingName,
        "billing_phone": billingPhone,
        "billing_email": billingEmail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

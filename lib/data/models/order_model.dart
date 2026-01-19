import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/generated/assets.dart';

class OrderModel {
  final int? id;
  int? addressId;
  final double? subtotal;
  final double? totalPrice;
  final double? discount;
  String? status;
  final String? paymentStatus;
  String? billingName;
  String? billingPhone;
  String? billingEmail;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductModel>? products;

  OrderModel({
    this.id,
    this.addressId,
    this.subtotal,
    this.totalPrice,
    this.discount,
    this.status,
    this.paymentStatus,
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
        subtotal: json["subtotal"] == null
            ? null
            : double.parse(json["subtotal"].replaceAll(',', '')),
        totalPrice: json["total_price"] == null
            ? null
            : double.parse(json["total_price"].replaceAll(',', '')),
        discount: json["discount"] == null
            ? null
            : double.parse(json["discount"].replaceAll(',', '')),
        status: json["status"],
        paymentStatus: json["payment_status"],
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
        "subtotal": subtotal,
        "total_price": totalPrice,
        "discount": discount,
        "status": status,
        "payment_status": paymentStatus,
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

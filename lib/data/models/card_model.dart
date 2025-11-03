import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';

class CardModel {
  List<ProductModel>? products;
  int? cartId;
  String? subtotal;
  String? discount;
  String? totalPrice;
  final String? couponType;
  final String? couponValue;
  final String? couponDiscount;

  CardModel({
    this.products,
    this.cartId,
    this.subtotal,
    this.discount,
    this.totalPrice,
    this.couponDiscount,
    this.couponType,
    this.couponValue,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cartId: json["cart_id"],
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"].map((x) => ProductModel.fromJson(x))),
        subtotal: json["subtotal"],
        discount: json["product_discount"],
        totalPrice: json["total_price"],
        couponType: json["coupon_type"],
        couponValue: json["coupon_value"],
        couponDiscount: json["coupon_discount"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "subtotal": subtotal,
        "product_discount": discount,
        "total_price": totalPrice,
        "coupon_discount": couponDiscount,
        "coupon_type": couponType,
        "coupon_value": couponValue,
      };

  // ✅ Formatters for display
  String get totalPriceFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(totalPrice ?? "0") ?? 0.0);
  String get discountFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(discount ?? "0") ?? 0.0);
  String get subtotalFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(subtotal ?? "0") ?? 0.0);
  String get couponDiscountFormat => PriceConverter.convertToNumberFormat(
        double.tryParse(couponDiscount ?? "0") ?? 0.0,
      );
}

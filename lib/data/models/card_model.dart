import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';

class CardModel {
  List<ProductModel>? products;
  String? cartId;
  num? subtotal;
  num? discount;
  num? totalPrice;

  CardModel({
    this.products,
    this.cartId,
    this.subtotal,
    this.discount,
    this.totalPrice,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cartId: _toString(json["cart_id"]),
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"].map((x) => ProductModel.fromJson(x))),
        subtotal: _toNum(json["subtotal"]),
        discount: _toNum(json["discount"]),
        totalPrice: _toNum(json["total_price"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "subtotal": subtotal,
        "discount": discount,
        "total_price": totalPrice,
      };

  // ✅ Formatters for display
  String get totalPriceFormat =>
      PriceConverter.convertToNumberFormat(totalPrice ?? 0.0);
  String get discountFormat =>
      PriceConverter.convertToNumberFormat(discount ?? 0.0);
  String get subtotalFormat =>
      PriceConverter.convertToNumberFormat(subtotal ?? 0.0);

  // ✅ Helper to handle both int, double, and string
  static num _toNum(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) {
      final parsed = num.tryParse(value);
      return parsed ?? 0;
    }
    return 0;
  }

  // ✅ Helper to handle both int and string for IDs or messages
  static String? _toString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    return value.toString();
  }
}

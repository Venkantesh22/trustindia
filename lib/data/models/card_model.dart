import 'package:lekra/data/models/product_model.dart';

class CardModel {
  List<ProductModel>? products;
  String? subtotal;
  String? discount;
  String? totalPrice;

  CardModel({
    this.products,
    this.subtotal,
    this.discount,
    this.totalPrice,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"]!.map((x) => ProductModel.fromJson(x))),
        subtotal: json["subtotal"],
        discount: json["discount"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "subtotal": subtotal,
        "discount": discount,
        "total_price": totalPrice,
      };
}

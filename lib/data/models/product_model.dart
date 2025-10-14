import 'dart:convert';

class ProductModel {
    final int? id;
    final String? name;
    final String? price;
    final String? offers;
    final String? description;
    final List<Image>? images;

    ProductModel({
        this.id,
        this.name,
        this.price,
        this.offers,
        this.description,
        this.images,
    });

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        offers: json["offers"],
        description: json["description"],
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "offers": offers,
        "description": description,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
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

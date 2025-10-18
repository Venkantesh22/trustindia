class AddressModel {
  int? id;
  int? userId;
  String? street;
  String? city;
  String? state;
  String? pincode;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressModel({
    this.id,
    this.userId,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        userId: json["user_id"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  String get fullAddress =>
      "${street ?? ''} ${city ?? ''} ${state ?? ''}${(pincode ?? '').isNotEmpty ? ', ${pincode}' : ''}"
          .trim();
}

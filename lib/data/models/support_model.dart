class SupportModel {
  final int? id;
  final String? mobile;
  final String? email;
  final String? whatsapp;

  SupportModel({
    this.id,
    this.mobile,
    this.email,
    this.whatsapp,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
        id: json["id"],
        mobile: json["mobile"],
        email: json["email"],
        whatsapp: json["whatsapp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile": mobile,
        "email": email,
        "whatsapp": whatsapp,
      };
}

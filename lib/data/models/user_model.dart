class UserModel {
  int? id;
  String? name;
  String? image;
  String? email;
  String? mobile;
  String? referralCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? currentWallet;
  final String? referralLink;
  final String? rewardPoint;

  UserModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.mobile,
    this.referralCode,
    this.createdAt,
    this.updatedAt,
    this.currentWallet,
    this.referralLink,
    this.rewardPoint,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        mobile: json["mobile"],
        referralCode: json["referral_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        currentWallet: json["current_wallet"] == null
            ? null
            : (json["current_wallet"] is num
                ? (json["current_wallet"] as num).toDouble()
                : double.tryParse(json["current_wallet"].toString())),
        rewardPoint: json["reward_point"],
        referralLink: json["referralLink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "email": email,
        "mobile": mobile,
        "referral_code": referralCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "current_wallet": currentWallet,
        "reward_point": rewardPoint,
        "referralLink": referralLink,
      };
}

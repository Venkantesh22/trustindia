class ReferralLevelDetailsModel {
  final String? name;
  final String? email;
  final String? referralCode;
  final String? walletBalance;
  final String? level;

  ReferralLevelDetailsModel({
    this.name,
    this.email,
    this.referralCode,
    this.walletBalance,
    this.level,
  });

  factory ReferralLevelDetailsModel.fromJson(Map<String, dynamic> json) =>
      ReferralLevelDetailsModel(
        name: json["name"],
        email: json["email"],
        referralCode: json["referral_code"],
        walletBalance: json["wallet_balance"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "referral_code": referralCode,
        "wallet_balance": walletBalance,
        "level": level,
      };
}

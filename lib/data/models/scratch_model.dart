import 'package:lekra/services/date_formatters_and_converters.dart';

class ScratchCardModel {
  final int? id;
  final String? code;
  final String? type;
  final String? rewardPoints;
  final DateTime? expiryDate;
  final int? isRedeemed;

  const ScratchCardModel({
    this.id,
    this.code,
    this.type,
    this.rewardPoints,
    this.expiryDate,
    this.isRedeemed,
  });

  factory ScratchCardModel.fromJson(Map<String, dynamic> json) =>
      ScratchCardModel(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        rewardPoints: json["reward_points"]?.toString(),
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.tryParse(json["expiry_date"]),
        isRedeemed: json["is_redeemed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "type": type,
        "reward_points": rewardPoints,
        "expiry_date": expiryDate?.toIso8601String(),
        "is_redeemed": isRedeemed,
      };

  bool get isScratch => (isRedeemed ?? 0) == 1;
  bool get isDiscount => type == "discount";
  bool get isExpiry =>    DateFormatters().dateTime.format(expiryDate ?? getDateTime()) == DateFormatters().dateTime.format( getDateTime());
}

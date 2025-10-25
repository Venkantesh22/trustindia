
class ScratchModel {
    final int? id;
    final String? code;
    final String? type;
    final String? rewardPoints;
    final DateTime? expiryDate;
    final int? isRedeemed;

    ScratchModel({
        this.id,
        this.code,
        this.type,
        this.rewardPoints,
        this.expiryDate,
        this.isRedeemed,
    });

    factory ScratchModel.fromJson(Map<String, dynamic> json) => ScratchModel(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        rewardPoints: json["reward_points"],
        expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
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
}

class DynamicModel {
  final String? vpa;
  final String? qrString;
  final int? orderId;
  final double? amount;

  DynamicModel({
    this.vpa,
    this.qrString,
    this.orderId,
    this.amount,
  });

  factory DynamicModel.fromJson(Map<String, dynamic> json) => DynamicModel(
        vpa: json["vpa"],
        qrString: json["qrString"],
        orderId: json["order_id"],
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "vpa": vpa,
        "qrString": qrString,
        "order_id": orderId,
        "amount": amount,
      };
}

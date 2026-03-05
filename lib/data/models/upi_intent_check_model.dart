class UpiIntentCheckModel {
  final int? orderId;
  final int? gatewayOrderId;
  final String? qrString;
  final String? amount;

  UpiIntentCheckModel({
    this.orderId,
    this.gatewayOrderId,
    this.qrString,
    this.amount,
  });

  factory UpiIntentCheckModel.fromJson(Map<String, dynamic> json) =>
      UpiIntentCheckModel(
        orderId: json["order_id"],
        gatewayOrderId: json["gateway_order_id"],
        qrString: json["qrString"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "gateway_order_id": gatewayOrderId,
        "qrString": qrString,
        "amount": amount,
      };
}

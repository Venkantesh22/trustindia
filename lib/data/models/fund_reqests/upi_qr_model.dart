class UpiQrModel {
  final String? orderId;
  final String? amount;
  final String? qrString;
  final int? gatewayOrderId;

  UpiQrModel({
    this.orderId,
    this.amount,
    this.gatewayOrderId,
    this.qrString,
  });

  factory UpiQrModel.fromJson(Map<String, dynamic> json) => UpiQrModel(
        orderId: json["order_id"],
        amount: json["amount"],
        qrString: json["qrString"],
        gatewayOrderId: json["gateway_order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "amount": amount,
        "qrString": qrString,
        "gateway_order_id": gatewayOrderId,
      };
}

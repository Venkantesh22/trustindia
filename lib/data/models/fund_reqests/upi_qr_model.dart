
class UpiQrModel {
    final String? orderId;
    final String? amount;
    final String? qrString;

    UpiQrModel({
        this.orderId,
        this.amount,
        this.qrString,
    });

    factory UpiQrModel.fromJson(Map<String, dynamic> json) => UpiQrModel(
        orderId: json["order_id"],
        amount: json["amount"],
        qrString: json["qrString"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "amount": amount,
        "qrString": qrString,
    };
}

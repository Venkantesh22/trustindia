class TransactionModel {
  int? id;
  String? type;
  double? amount;
  String? balanceAfter;
  String? description;
  DateTime? createdAt;
  final String? orderId;
  final String? gatewayOrderId;
  final String? status;
  final String? utr;

  TransactionModel({
    this.id,
    this.type,
    this.amount,
    this.balanceAfter,
    this.description,
    this.createdAt,
    this.orderId,
    this.gatewayOrderId,
    this.status,
    this.utr,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        type: json["type"],
        amount: json["amount"] == null ? null : double.parse(json["amount"]),
        balanceAfter: json["balance_after"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]).toLocal(),
        orderId: json["order_id"],
        gatewayOrderId: json["gateway_order_id"],
        status: json["status"],
        utr: json["utr"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "gateway_order_id": gatewayOrderId,
        "id": id,
        "type": type,
        "amount": amount,
        "balance_after": balanceAfter,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "utr": utr,
      };

  bool get isDebit => (type?.toLowerCase() == "debit");
}

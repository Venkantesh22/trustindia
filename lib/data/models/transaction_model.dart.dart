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
  final String? product; // Added to capture 'addfund'

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
    this.product,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        // If 'type' is missing but 'product' is 'addfund', treat it as a credit
        type: json["type"] ?? (json["product"] == "addfund" ? "credit" : null),
        // Safely parse amount whether it comes as String, Int, or Double
        amount: json["amount"] == null
            ? null
            : double.tryParse(json["amount"].toString()),
        balanceAfter: json["balance_after"]?.toString(),
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]).toLocal(),
        orderId: json["order_id"]?.toString(),
        gatewayOrderId: json["gateway_order_id"]?.toString(),
        status: json["status"],
        utr: json["utr"]?.toString(),
        product: json["product"],
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
        "product": product,
      };

  bool get isDebit => (type?.toLowerCase() == "debit");
}

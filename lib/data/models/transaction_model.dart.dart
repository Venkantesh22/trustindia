class TransactionModel {
  int? id;
  String? type;
  double? amount;
  String? balanceAfter;
  String? description;
  DateTime? createdAt;

  TransactionModel({
    this.id,
    this.type,
    this.amount,
    this.balanceAfter,
    this.description,
    this.createdAt,
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
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "balance_after": balanceAfter,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
      };

  bool get isDebit => (type?.toLowerCase() == "debit");

}

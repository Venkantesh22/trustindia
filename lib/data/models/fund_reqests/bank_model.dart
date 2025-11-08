class BankModel {
  final int? id;
  final int? userId;
  final String? accountName;
  final String? accountNumber;
  final String? ifsc;

  BankModel({
    this.id,
    this.userId,
    this.accountName,
    this.accountNumber,
    this.ifsc,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["id"],
        userId: json["user_id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        ifsc: json["ifsc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "account_name": accountName,
        "account_number": accountNumber,
        "ifsc": ifsc,
      };
}

import 'package:lekra/data/models/fund_reqests/bank_model.dart';
import 'package:lekra/services/constants.dart';

class FundRequestsModel {
  final int? id;
  final int? userId;
  final String? utr;
  final String? cancelReason;
  final DateTime? transDate;
  final String? amount;
  final int? bankId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BankModel? bankaccount;
      final String? accountName;


  FundRequestsModel({
    this.id,
    this.userId,
    this.utr,
    this.cancelReason,
    this.transDate,
    this.amount,
    this.bankId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bankaccount,
    this.accountName,
  });

  factory FundRequestsModel.fromJson(Map<String, dynamic> json) =>
      FundRequestsModel(
        id: json["id"],
        userId: json["user_id"],
        utr: json["utr"],
        cancelReason: json["cancelReason"],
        transDate: json["trans_date"] == null
            ? null
            : DateTime.parse(json["trans_date"]),
        amount: json["amount"],
        bankId: json["bank_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bankaccount: json["bankaccount"] == null
            ? null
            : BankModel.fromJson(json["bankaccount"]),
             accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "utr": utr,
        "cancelReason": cancelReason,
        "trans_date":
            "${transDate!.year.toString().padLeft(4, '0')}-${transDate!.month.toString().padLeft(2, '0')}-${transDate!.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "bank_id": bankId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "bankaccount": bankaccount?.toJson(),
         "account_name": accountName,
      };

  String get amountFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(amount ?? "") ?? 0.0);

  FundStatus get statusFormat => _parseStatus(status);
}

enum FundStatus { pending, successful, cancelled, unknown }

/// ✅ Helper method that converts a string to a FundStatus enum safely.
FundStatus _parseStatus(String? value) {
  final lower = (value ?? '').trim().toLowerCase();
  switch (lower) {
    case 'pending':
      return FundStatus.pending;
    case 'success':
    case 'successful':
    case 'approved':
      return FundStatus.successful;
    case 'cancel':
    case 'cancelled':
    case 'canceled':
    case 'rejected':
      return FundStatus.cancelled;
    default:
      return FundStatus.unknown;
  }
}

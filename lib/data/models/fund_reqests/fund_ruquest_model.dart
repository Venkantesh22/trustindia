class FundRequestModel {
  final String id;
  final DateTime dateTime;
  final String utr;
  final String bank;
  final double amount;
  final FundStatus status;
  final String? cancelReason;

  FundRequestModel({
    required this.id,
    required this.dateTime,
    required this.utr,
    required this.bank,
    required this.amount,
    required this.status,
    this.cancelReason,
  });
}

enum FundStatus { pending, successful, cancelled }

List<FundRequestModel> fundRequestList = [
  FundRequestModel(
      id: "djlkdjdl",
      dateTime: DateTime.now(),
      utr: "1232323232323",
      bank: "SBI",
      amount: 1001,
      status: FundStatus.pending),
];

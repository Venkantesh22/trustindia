import 'package:lekra/services/constants.dart';

class WalletModel {
  final String? wallet;

  WalletModel({
    this.wallet,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        wallet: json["wallet"],
      );

  Map<String, dynamic> toJson() => {
        "wallet": wallet,
      };

  String get walletBalance =>
      PriceConverter.convertToNumberFormat(double.parse(wallet ?? ""));
}

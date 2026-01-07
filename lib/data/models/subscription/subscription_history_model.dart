import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';

class SubscriptionHistoryModel {
  final int? subscriptionId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? status;
  final String? planName;
  final String? price;
  final String? discountPrice;
  final int? totalDays;
  final int? usedDays;
  final int? remainingDays;

  SubscriptionHistoryModel({
    this.subscriptionId,
    this.startDate,
    this.endDate,
    this.status,
    this.planName,
    this.price,
    this.discountPrice,
    this.totalDays,
    this.usedDays,
    this.remainingDays,
  });

  factory SubscriptionHistoryModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionHistoryModel(
        subscriptionId: json["subscription_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        planName: json["plan_name"],
        price: json["price"],
        discountPrice: json["discount_price"],
        totalDays: json["total_days"],
        usedDays: json["used_days"],
        remainingDays: json["remaining_days"],
      );

  Map<String, dynamic> toJson() => {
        "subscription_id": subscriptionId,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "plan_name": planName,
        "price": price,
        "discount_price": discountPrice,
        "total_days": totalDays,
        "used_days": usedDays,
        "remaining_days": remainingDays,
      };
  bool get isActive => remainingDays != 0;

  String get priceFormat =>
      PriceConverter.convertToNumberFormat(double.tryParse(price ?? "") ?? 0.0);

  String get discountPriceFormat => PriceConverter.convertToNumberFormat(
      double.tryParse(discountPrice ?? "") ?? 0.0);

  String get startDateFormat =>
      DateFormatters().dMyDash2.format(startDate ?? getDateTime());

  String get endDateFormat =>
      DateFormatters().dMyDash2.format(endDate ?? getDateTime());
}

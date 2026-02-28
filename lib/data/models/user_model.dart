import 'package:lekra/data/models/subscription/subscription_history_model.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';

class UserModel {
  int? id;
  final String? firstName;
  final String? lastName;
  final dynamic gender;
  final int? isVerified;
  String? image;
  String? email;
  String? mobile;
  String? referralCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? dob;
  double? currentWallet;
  final String? referralLink;
  final int? rewardPoint;
  final ReferralLinks? referralLinks;
  final ReferredLevel? referredLevel;

  final SubscriptionHistoryModel? subscription;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.isVerified,
    this.image,
    this.email,
    this.mobile,
    this.referralCode,
    this.createdAt,
    this.updatedAt,
    this.dob,
    this.currentWallet,
    this.referralLink,
    this.rewardPoint,
    this.referralLinks,
    this.subscription,
    this.referredLevel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"].toString(),
        lastName: json["last_name"].toString(),
        gender: json["gender"],
        isVerified: json["is_verified"],
        image: json["image"],
        email: json["email"],
        mobile: json["mobile"],
        referralCode: json["referral_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        currentWallet: json["current_wallet"] == null
            ? null
            : (json["current_wallet"] is num
                ? (json["current_wallet"] as num).toDouble()
                : double.tryParse(json["current_wallet"].toString())),
        rewardPoint: json["reward_point"] is String
            ? int.tryParse(json["reward_point"])
            : json["reward_point"],
        referralLink: json["referralLink"],
        referralLinks: json["referral_links"] == null
            ? null
            : ReferralLinks.fromJson(json["referral_links"]),
        subscription: json["subscription"] == null
            ? null
            : SubscriptionHistoryModel.fromJson(json["subscription"]),
        referredLevel: json["referred_level"] == null
            ? null
            : ReferredLevel.fromJson(json["referred_level"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "is_verified": isVerified,
        "image": image,
        "email": email,
        "mobile": mobile,
        "referral_code": referralCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "dob": dob?.toIso8601String(),
        "current_wallet": currentWallet,
        "reward_point": rewardPoint,
        "referralLink": referralLink,
        "referral_links": referralLinks?.toJson(),
        "subscription": subscription?.toJson(),
        "referred_level": referredLevel?.toJson(),
      };

  String get fullName => "$firstName $lastName";
  bool get isPhoneVerified => isVerified == 1 ? true : false;
  String get dobFormat => DateFormatters().dMyDash.format(dob ?? getDateTime());
}

class ReferredLevel {
  final int? totalDownline;
  final int? levelsCompleted;
  final String? currentRank;
  final String? nextRank;
  final int? peopleNeededForNextRank;

  ReferredLevel({
    this.totalDownline,
    this.levelsCompleted,
    this.currentRank,
    this.nextRank,
    this.peopleNeededForNextRank,
  });

  factory ReferredLevel.fromJson(Map<String, dynamic> json) => ReferredLevel(
        totalDownline: json["total_downline"],
        levelsCompleted: json["levels_completed"],
        currentRank: json["current_rank"],
        nextRank: json["next_rank"],
        peopleNeededForNextRank: json["people_needed_for_next_rank"],
      );

  Map<String, dynamic> toJson() => {
        "total_downline": totalDownline,
        "levels_completed": levelsCompleted,
        "current_rank": currentRank,
        "next_rank": nextRank,
        "people_needed_for_next_rank": peopleNeededForNextRank,
      };
}

class ReferralLinks {
  final String? web;
  final String? app;
  final String? playstore;

  ReferralLinks({
    this.web,
    this.app,
    this.playstore,
  });

  factory ReferralLinks.fromJson(Map<String, dynamic> json) => ReferralLinks(
        web: json["web"],
        app: json["app"],
        playstore: json["playstore"],
      );

  Map<String, dynamic> toJson() => {
        "web": web,
        "app": app,
        "playstore": playstore,
      };
}

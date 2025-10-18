// import '../../../services/enums/gender.dart';

// // class UserBodyModel {
// class UserModel {
//     int? id;
//     String? name;
//     String? email;
//     String? mobile;
//     String? referralCode;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     String? currentWallet;

//     UserModel({
//         this.id,
//         this.name,
//         this.email,
//         this.mobile,
//         this.referralCode,
//         this.createdAt,
//         this.updatedAt,
//         this.currentWallet,
//     });

//     factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         mobile: json["mobile"],
//         referralCode: json["referral_code"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         currentWallet: json["current_wallet"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "mobile": mobile,
//         "referral_code": referralCode,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "current_wallet": currentWallet,
//     };
// }

// //   UserBodyModel({
// //     this.name,
// //     this.contact,
// //     this.schoolId,
// //     this.dob,
// //     this.gender,
// //   });

// //   String? name;
// //   String? contact;
// //   String? schoolId;
// //   String? dob;
// //   Gender? gender;

// //   factory UserBodyModel.fromJson(Map<String, dynamic> json) => UserBodyModel(
// //         name: json["name"],
// //         contact: json["phone"],
// //         schoolId: json["school_id"],
// //         dob: json["date_of_birth"],
// //         gender: json["gender"] == null
// //             ? null
// //             : json["gender"] == 'male'
// //                 ? Gender.male
// //                 : Gender.female,
// //       );

// //   Map<String, String> toJson() => {
// //         if (name != null) "name": '$name',
// //         if (contact != null) "phone": '$contact',
// //         if (schoolId != null) "school_id": '$schoolId',
// //         if (gender != null) "gender": gender!.name.toLowerCase(),
// //         if (dob != null) "date_of_birth": '$dob',
// //       };
// // }

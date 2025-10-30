import 'package:flutter/material.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';

class RowOfUPIOption extends StatelessWidget {
  final String? image;
  final String title;
  final Function()? onTap;

  const RowOfUPIOption({
    super.key,
    this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                image != null
                    ? Row(
                        children: [
                          CustomImage(
                            path: image ?? "",
                            height: 26,
                            width: 26,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    : SizedBox(),
                Text(
                  title,
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}

class UpiOptionModel {
  final String? image;
  final String title;
  final Function()? onTap;

  UpiOptionModel({this.image, required this.title, required this.onTap});
}

List<UpiOptionModel> upiOptionList = [
  UpiOptionModel(
      image: Assets.imagesGooglePay, title: "Google Pay", onTap: () {}),
  UpiOptionModel(image: Assets.imagesPhonePe, title: "PhonePe", onTap: () {}),
  UpiOptionModel(
      image: Assets.imagesUpi, title: "Pay with Other UPI Apps", onTap: () {}),
  UpiOptionModel(title: "Pay with Credit/Debit Card", onTap: () {}),
  UpiOptionModel(title: "Dynamic QR", onTap: () {}),
];

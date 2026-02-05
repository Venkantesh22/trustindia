import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class PremiumBenefitContainer extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  const PremiumBenefitContainer(
      {super.key,
      required this.image,
      required this.title,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.18
      padding: const EdgeInsets.fromLTRB(25, 19, 25, 23),
      decoration: BoxDecoration(
        color: greyVeryDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            path: image,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Helper(context).textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: yellow,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  overflow: TextOverflow.clip,
                  style: Helper(context).textTheme.titleLarge?.copyWith(
                        fontSize: 12,
                        height: 2.2,
                        fontWeight: FontWeight.w400,
                        color: white,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

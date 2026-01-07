import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class PremiumBottomSection extends StatelessWidget {
  const PremiumBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svgsStar,
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "CURRENT BENEFITS",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: yellow,
                    ),
              ),
            ),
            SvgPicture.asset(
              Assets.svgsStar,
              height: 20,
              width: 20,
            ),
          ],
        ),
        SizedBox(height: 16),
       
      ],
    );
  }
}

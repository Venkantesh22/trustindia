import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lekra/data/models/scratch_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';

class ScratchCardWidget extends StatelessWidget {
  final ScratchCardModel scratchCardModel;

  const ScratchCardWidget({
    super.key,
    required this.scratchCardModel,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();

    // 🎨 Generate two random gradient colors
    Color randomColor1 = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    Color randomColor2 = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );

    Widget cardContent;

    if (scratchCardModel.isScratch) {
      cardContent = Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [randomColor1, randomColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scratchCardModel.isDiscount
                          ? "🎉 You've won a Discount!"
                          : "🎁 You've won!",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      scratchCardModel.isDiscount
                          ? "${scratchCardModel.rewardPoints} OFF"
                          : "${scratchCardModel.rewardPoints} Points",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      cardContent = Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const CustomImage(
          path: Assets.imagesScratch,
          fit: BoxFit.cover,
        ),
      );
    }

    if (scratchCardModel.isExpiry) {
      return ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0, //
          0.2126, 0.7152, 0.0722, 0, 0, //
          0.2126, 0.7152, 0.0722, 0, 0, //
          0, 0, 0, 1, 0, //
        ]),
        child: cardContent,
      );
    }

    return cardContent;
  }
}

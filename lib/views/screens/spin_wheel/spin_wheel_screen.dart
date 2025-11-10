// ignore_for_file: unused_element

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/reward_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_back_button.dart';
import 'package:lekra/views/screens/widget/custom_back_button.dart';

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({super.key});

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  final _controller = StreamController<int>();
  final _rng = Random();

  int? _lastFocusedIndex;
  int? _displayedWinnerIndex;
  int _resultVersion = 0;
  // String winner = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RewardsController>().fetchSpinWheel();
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _spin(RewardsController c) {
    final items = c.spinWheelList;
    if (items.length < 1) return;
    // setState(() => winner = "");
    // Ensure index is within bounds
    final index = _rng.nextInt(items.length);
    _controller.add(index);
  }

  // optional: per-slice colors
  static const _sliceColors = <Color>[
    Color(0xFF0D80F2),
    Color(0xFF8DC3F9),
    Color(0xFF0D80F2),
    Color(0xFF8DC3F9),
    Color(0xFF0D80F2),
    Color(0xFF0C25E6),
  ];

  @override
  Widget build(BuildContext context) {
    const borderColor = Colors.orange;
    const size = 354.0;

    return Scaffold(
      appBar: const CustomAppbarBackButton(),
      body: GetBuilder<RewardsController>(
        builder: (c) {
          final raw = c.spinWheelList; // your data source

          // Loading state (adjust to your controller's flags if you have them)
          if (raw.isEmpty && c.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }

          // Empty state
          if (raw.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outline,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(
                      'No spin items available right now.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: c.fetchSpinWheel,
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            );
          }

          // FortuneWheel requires > 1 item. If exactly 1, duplicate it.
          final data = raw.length == 1 ? [raw.first, raw.first] : raw;

          final canSpin = data.length > 1;

          return GetBuilder<RewardsController>(builder: (rewardsController) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size + 16,
                      height: size + 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 6),
                      ),
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            FortuneWheel(
                              selected: _controller.stream,
                              indicators: <FortuneIndicator>[
                                FortuneIndicator(
                                  alignment: Alignment.topCenter,
                                  child: Transform.translate(
                                    offset: const Offset(0, -30),
                                    child: TriangleIndicator(
                                      color: secondaryColor,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ],
                              onFocusItemChanged: (i) {
                                if (_lastFocusedIndex == i) return;
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (!mounted) return;
                                  setState(() => _lastFocusedIndex = i);
                                });
                              },
                              onAnimationEnd: () {
                                final idx = _lastFocusedIndex;
                                if (idx == null) return;
                                setState(() {
                                  _displayedWinnerIndex = idx;
                                  _resultVersion++;
                                  rewardsController
                                      .setWinSpinWheelModel(data[idx]);
                                  rewardsController
                                      .postCreateScratchCard()
                                      .then((value) {
                                    if (value.isSuccess) {
                                      showToast(
                                          message: value.message,
                                          typeCheck: value.isSuccess);
                                    } else {
                                      showToast(
                                          message: value.message,
                                          typeCheck: value.isSuccess);
                                    }
                                  });
                                });
                              },
                              // ✅ Use spinWheelList length consistently
                              items: List.generate(data.length, (i) {
                                final item = data[i];
                                return FortuneItem(
                                  child: Center(
                                    child: Text(
                                      "            ${item.offerName}",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  style: FortuneItemStyle(
                                    color:
                                        _sliceColors[i % _sliceColors.length],
                                    borderWidth: 2,
                                    borderColor:
                                        Colors.white.withValues(alpha: 0.6),
                                  ),
                                );
                              }),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 62,
                                width: 62,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: canSpin ? Colors.orange : Colors.grey,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      spreadRadius: 0,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  canSpin ? "SPIN" : "WAIT",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Winner text
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: (_displayedWinnerIndex == null ||
                              rewardsController.winSpinWheelModel == null)
                          ? const SizedBox(key: ValueKey('empty'), height: 24)
                          : Text(
                              '🎉 You won: ${rewardsController.winSpinWheelModel?.offerName ?? ""}',
                              key: ValueKey('res-$_resultVersion'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                    ),

                    const SizedBox(height: 55),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: rewardsController.winSpinWheelModel != null
                          ? Container(
                              key: ValueKey(rewardsController
                                  .winSpinWheelModel?.offerName),
                              width: 263,
                              height: 69,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xEDFF7700),
                                    Color(0x8F0D80F2),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "🎉 Congratulations!",
                                    style: Helper(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'You won: ${rewardsController.winSpinWheelModel?.offerName}',
                                    style: Helper(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: white,
                                        ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

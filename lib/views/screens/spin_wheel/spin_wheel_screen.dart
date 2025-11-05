import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({super.key});

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  final _controller = StreamController<int>();
  final _rng = Random();

  final List<String> items = const [
    '20 Points',
    '20 % off',
    '30 Points',
    '15% off',
    '20 Points',
    'No Discount',
    '10% off ',
  ];

  // Optional: per-slice colors (cycles if fewer/more)
  final List<Color> sliceColors = const [
    Color(0xFF0D80F2),
    Color(0xFF8DC3F9),
    Color(0xFF0D80F2),
    Color(0xFF8DC3F9),
    Color(0xFF0D80F2),
    Color(0xFF0C25E6),
    Color(0xFF8DC3F9),
  ];

  int? _lastFocusedIndex;
  int? _displayedWinnerIndex;
  int _resultVersion = 0;
  String winner = "";

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _spin() {
    setState(() {
      winner = "";
    });
    final index = _rng.nextInt(items.length);
    _controller.add(index); // triggers the spin
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Colors.orange; // outer border color
    const size = 354.0;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // safety if you add more widgets later
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size + 16,
                height: size + 16,
                // padding: const EdgeInsets.all(8),
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
                              offset: Offset(0, -30),
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
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!mounted) return;
                            setState(() => _lastFocusedIndex = i);
                          });
                        },
                        onAnimationEnd: () {
                          final idx = _lastFocusedIndex;
                          if (idx == null) return;

                          setState(() {
                            winner = items[idx];

                            _displayedWinnerIndex = idx;
                            _resultVersion++;
                          });
                        },
                        items: List.generate(items.length, (i) {
                          return FortuneItem(
                            child: Text(
                              items[i],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: FortuneItemStyle(
                              color: sliceColors[i % sliceColors.length],
                              borderWidth: 2,
                              borderColor: Colors.white.withOpacity(0.6),
                            ),
                          );
                        }),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _spin,
                          child: Container(
                            height: 62,
                            width: 62,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Text(
                              "SPIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Winner text – updates only once per spin to avoid duplicate keys
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: (_displayedWinnerIndex == null)
                    ? const SizedBox(
                        key: ValueKey('empty'),
                        height: 24,
                      )
                    : Text(
                        '🎉 You won: ${items[_displayedWinnerIndex!]}',
                        key: ValueKey('res-$_resultVersion'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
              ),

              const SizedBox(
                height: 55,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: winner.isNotEmpty
                    ? Container(
                        key: ValueKey(winner),
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
                              style:
                                  Helper(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: white,
                                      ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'You won: $winner',
                              style:
                                  Helper(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

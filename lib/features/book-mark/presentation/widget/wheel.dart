import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class CleanWheel extends StatefulWidget {
  const CleanWheel({super.key});

  @override
  State<CleanWheel> createState() => _CleanWheelState();
}

class _CleanWheelState extends State<CleanWheel>
    with SingleTickerProviderStateMixin {
  // ✔️ أهم شيء: broadcast stream
  final StreamController<int> controller =
      StreamController<int>.broadcast();

  late AnimationController glowController;
  late Animation<double> glowAnimation;

  bool isSpinning = false;

  final List<String> items = [
    "إجازة",
    "مكافأة",
    "خصم",
    "هدية",
    "محاولة جديدة",
  ];

  final List<Color> wheelColors = const [
    Color(0xFF2196F3),
    Color(0xFF1E88E5),
    Color(0xFF1976D2),
    Color(0xFF64B5F6),
    Color(0xFF0D47A1),
  ];

  @override
  void initState() {
    super.initState();

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    glowAnimation = Tween<double>(begin: 0.3, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(glowController);
  }

  @override
  void dispose() {
    controller.close();
    glowController.dispose();
    super.dispose();
  }

  void spin() {
    isSpinning = true;
    glowController.repeat(reverse: true);

    // ✔️ نضمن قيمة جديدة كل مرة
    controller.add(Random().nextInt(items.length));

    Future.delayed(const Duration(seconds: 4), () {
      glowController.stop();
      glowController.value = 0.3;
      isSpinning = false;
      setState(() {});
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 🔥 Glow بسيط (نار خفيفة)
                AnimatedBuilder(
                  animation: glowAnimation,
                  builder: (context, _) {
                    return Container(
                      width: 330,
                      height: 330,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(
                              glowAnimation.value,
                            ),
                            blurRadius: 60 * glowAnimation.value,
                            spreadRadius: 15 * glowAnimation.value,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // 🎡 Fortune Wheel (مهم جداً يكون خارج أي AnimatedBuilder)
                SizedBox(
                  width: 300,
                  height: 300,
                  child: FortuneWheel(
                    selected: controller.stream,
                    animateFirst: false,
                    duration: const Duration(seconds: 4),
                    curve: Curves.fastLinearToSlowEaseIn,
                    indicators: const [
                      FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: TriangleIndicator(
                          color: Colors.blueAccent,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                    items: [
                      for (int i = 0; i < items.length; i++)
                        FortuneItem(
                          child: Text(
                            items[i],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: FortuneItemStyle(
                            color: wheelColors[i % wheelColors.length],
                            borderColor: Colors.white,
                            borderWidth: 3,
                          ),
                        ),
                    ],
                  ),
                ),

                // 🔥 شرارات بسيطة (بدون حسابات معقدة)
                if (isSpinning)
                  ...List.generate(8, (i) {
                    return Positioned(
                      left: 150 + Random().nextInt(40) - 20,
                      top: 150 + Random().nextInt(40) - 20,
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.8),
                              blurRadius: 6,
                            )
                          ],
                        ),
                      ),
                    );
                  }),

                // 🍀 Logo بالنص
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.casino,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        ElevatedButton(
          onPressed: spin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "لفّي الدولاب",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

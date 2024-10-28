import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class CatergoryPage extends StatefulWidget {
  const CatergoryPage({super.key});

  @override
  State<CatergoryPage> createState() => _CatergoryPageState();
}

class _CatergoryPageState extends State<CatergoryPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: BubblesBehaviour(
        options: BubbleOptions(
          popRate: 1,
          minTargetRadius: 1.0,
          bubbleCount: 30,
          maxTargetRadius: 5.0,
          growthRate: 150.0,
        ),
      ),
      vsync: this,
      child: SingleChildScrollView(
        child: Column(
            // children: [SliderSection()],
            ),
      ),
    );
  }
}

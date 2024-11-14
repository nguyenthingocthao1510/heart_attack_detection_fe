import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultIsOne extends StatelessWidget {
  const ResultIsOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: 'You are ',
          style: TextStyle(
            fontSize: 64,
            color: Colors.white
          ),
          children: <InlineSpan> [
            TextSpan(
              text: 'more likely ',
              style: TextStyle(
                color: Color.fromARGB(255, 252, 95, 84),
                fontWeight: FontWeight.bold
              )
            ),
            TextSpan(
              text: 'to have heart attack',
            ),
          ]
        )
      ).animate()
      .fade(
        duration: const Duration(milliseconds: 3000),
        begin: 0.1,
        end: 1
      )
      .scale(
        delay: const Duration(milliseconds: 1000),
        duration: const Duration(milliseconds: 1000),
        begin: const Offset(0, 0),
        end: const Offset(1, 1),
        curve: Curves.easeInOut,
      )
      .then(delay: const Duration(milliseconds: 100))
      .scale(
        duration: const Duration(milliseconds: 800),
        begin: const Offset(1.2, 1.2),
        end: const Offset(1, 1),
        curve: Curves.easeInOut,
      )
    );
  }
}

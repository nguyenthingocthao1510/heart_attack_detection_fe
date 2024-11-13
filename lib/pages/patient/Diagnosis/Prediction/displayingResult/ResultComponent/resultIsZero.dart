import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultIsZero extends StatelessWidget {
  const ResultIsZero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Text(
        'Congratulation! There is no sign of heart attack',
        style: TextStyle(
          fontSize: 64
          ),
        textAlign: TextAlign.center,
      )
    ).animate()
      .fadeIn(
        
      )
    ;
  }
}

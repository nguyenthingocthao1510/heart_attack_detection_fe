import 'package:flutter/material.dart';

class ResultIsZero extends StatelessWidget {
  const ResultIsZero({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Text(
            'Congratulation! There is no sign of heart attack',
            style: TextStyle(
              fontSize: 64
              ),
            textAlign: TextAlign.center,
          )
        ]
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ResultIsOne extends StatelessWidget {
  const ResultIsOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Text(
            'Warning! There is a risk of heart attack',
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

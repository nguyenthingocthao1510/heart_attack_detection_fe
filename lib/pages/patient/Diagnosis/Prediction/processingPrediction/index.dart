import 'package:flutter/material.dart';

class ProcessingPrediction extends StatelessWidget {
  const ProcessingPrediction({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Predicting..."),
        ],
      ),
    );
  }
}

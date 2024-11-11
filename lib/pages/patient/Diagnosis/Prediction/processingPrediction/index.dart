import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';

class ProcessingPrediction extends StatelessWidget {
  const ProcessingPrediction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 225, 225, 225),
              borderRadius: BorderRadius.circular(300)
            ),
            child: Image.asset(
              heartImage,
              fit: BoxFit.contain
            ).animate(
                onComplete: (controller) => controller.repeat()
              )
              .scale(
                duration: const Duration(milliseconds: 500),
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.2, 1.2),
                curve: Curves.easeInOut,
              )
              .then(delay: const Duration(milliseconds: 100))
              .scale(
                duration: const Duration(milliseconds: 500),
                begin: const Offset(1.2, 1.2),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeInOut,
              ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import '../index.dart';


class ProcessPrediction extends StatelessWidget {
  const ProcessPrediction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
                "Predicting, please wait...",
                style: CustomTextStyle.textStyle1(32, Colors.black)
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Center(
          child: Container(
            height: 300,
            width: 300,
            child: Image.asset(
              heartImage,
              fit: BoxFit.contain
            ).animate(
                onComplete: (controller) => controller.repeat()
              )
              .scale(
                duration: const Duration(milliseconds: 400),
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.2, 1.2),
                curve: Curves.easeInOut,
              )
              .then(delay: const Duration(milliseconds: 200))
              .scale(
                duration: const Duration(milliseconds: 400),
                begin: const Offset(1.2, 1.2),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeInOut,
              )
            ),
          ),
          const Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.2,
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 20, 139, 251)),
            ),
            onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Prediction()),
            );
            }, 
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white
              ),
            )
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'ResultComponent/resultIsOne.dart';
import 'ResultComponent/resultIsZero.dart';
import '../index.dart';

class DisplayingResult extends StatefulWidget {
  final String result;

  const DisplayingResult({Key? key, required this.result}) : super(key: key);

  @override
  State<DisplayingResult> createState() => _DisplayingResultState();
}

class _DisplayingResultState extends State<DisplayingResult> {
  @override
  Widget build(BuildContext context) {
    Widget resultWidget;

    final int prediction = int.tryParse(widget.result) ?? -1;

    if (prediction == 0) {
      resultWidget = const ResultIsZero();
    } else if (prediction == 1) {
      resultWidget = const ResultIsOne();
    } else {
      resultWidget = const Text(
        'Error: Invalid result',
        style: TextStyle(color: Colors.red, fontSize: 20),
      );
    }

    return Scaffold(
      body: Column(
        children: [
        resultWidget,
        const SizedBox(height: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 20, 139, 251)),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Prediction()),
            );
          },
          child: const Text(
            "Back",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ],
      ),
    );
  }
}

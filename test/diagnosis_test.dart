import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/processingPrediction/index.dart';

void main() {
  testWidgets('Preview enteringInformation page', (WidgetTester tester) async {
    // Wrap your widget in a MaterialApp for proper rendering
    await tester.pumpWidget(MaterialApp(
      home: ProcessingPrediction(), // or '0' to test the other page
    ));

    // Use this line to hold the page open while testing
    await tester.pump(const Duration(seconds: 5));
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/enteringInformation/index.dart';

void main() {
  testWidgets('Preview enteringInformation page', (WidgetTester tester) async {
    // Wrap your widget in a MaterialApp for proper rendering
    await tester.pumpWidget(EnteringInformation(onSubmit: ''));

    // Use this line to hold the page open while testing
    await tester.pumpAndSettle();
  });
}

import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Login/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Register/index.dart';
import 'package:heart_attack_detection_fe/pages/notFound/notFound.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/index.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        // login: (context) => const Login(),
        // homePage: (context) => const HomePage(),
        // registerRoute: (context) => const Register(),
        // notFoundRoute: (context) => const Error404Screen(),
        diagnosisRoute: (context) => const Prediction(),
      },
    );
  }
}

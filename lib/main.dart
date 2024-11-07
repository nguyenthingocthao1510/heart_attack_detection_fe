import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Login/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/ModuleAuthorization/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Register/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/UserFooter/index.dart';
import 'package:heart_attack_detection_fe/pages/notFound/notFound.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/index.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hoverColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        login: (context) => const Login(),
        homePage: (context) => const HomePage(),
        registerRoute: (context) => const Register(),
        moduleAuthorization: (context) => const ModuleAuthorization(),
        dashboard: (context) => const Dashboard(),
        userInformation: (context) => const UserFooterSection(),
        notFoundRoute: (context) => const Error404Screen(),
      },
    );
  }
}

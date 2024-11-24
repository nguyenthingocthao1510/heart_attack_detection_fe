import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Login/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/ModuleAuthorization/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/PermissionAuthorization/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Register/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/UserFooter/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/PrescriptionDetail/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/PrescriptionModal/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/index.dart';
import 'package:heart_attack_detection_fe/pages/notFound/notFound.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RoleProvider()),
      ChangeNotifierProvider(create: (context) => PermissionProvider()),
      ChangeNotifierProvider(create: (context) => AccountProvider())
    ],
    child: const MyApp(),
  ));
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
      initialRoute: login, // Start with the login route
      routes: {
        login: (context) => const Login(),
        homePage: (context) => const HomePage(),
        registerRoute: (context) => const Register(),
        moduleAuthorization: (context) => const ModuleAuthorization(),
        dashboard: (context) => const Dashboard(),
        userInformation: (context) => const UserFooterSection(),
        permissionAuthorization: (context) => const PermissionAuthorization(),
        prescription: (context) => const PrescriptionPage(),
        addPrescription: (context) => PrescriptionModal(),
        prescriptionDetail: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is int) {
            return PrescriptionDetail(prescriptionId: args);
          }
          // Return Error page if no arguments are passed
          return const Error404Screen();
        },
        notFoundRoute: (context) => const Error404Screen(),
      },
    );
  }
}

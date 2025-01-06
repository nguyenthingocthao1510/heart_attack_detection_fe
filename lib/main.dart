import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/utils/exporters/adminPages.dart';
import 'package:heart_attack_detection_fe/utils/exporters/doctorPages.dart';
import 'package:heart_attack_detection_fe/utils/exporters/patientPages.dart';

import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/doctorApi.dart';
import 'package:heart_attack_detection_fe/services/baseApi.dart';
import 'package:provider/provider.dart';

Future<Doctor?> getDoctorById(BuildContext context) async {
  try {
    final accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId;
    if (accountId == null) return null;

    final response = await DoctorAPI.getDoctorById(int.parse(accountId));
    return response;
  } catch (e) {
    print('Error fetching doctor data: $e');
    return null;
  }
}

void main() {
  ChangePrefixURL.setApiPrefix(4);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RoleProvider()),
      ChangeNotifierProvider(create: (context) => PermissionProvider()),
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => PatientProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hoverColor: Colors.white,
      ),
      routes: {
        login: (context) => const Login(),
        homePage: (context) => const HomePage(),
        registerRoute: (context) => const Register(),
        moduleAuthorization: (context) => const ModuleAuthorization(),
        deviceRoute: (context) => const DevicePage(),
        dashboard: (context) => const Dashboard(),
        diagnosisRoute: (context) => const Prediction(),
        historyRoute: (context) => const DiagnosisHistory(),
        patientProfileRoute: (context) => const PatientProfile(),
        userInformation: (context) => const UserFooterSection(),
        permissionAuthorization: (context) => const PermissionAuthorization(),
        prescription: (context) => const PrescriptionPage(),
        addPrescription: (context) => PrescriptionModal(),
        prescriptionDetail: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is int) {
            return PrescriptionDetail(prescriptionId: args);
          }
          return const Error404Screen();
        },
        doctorRoute: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final doctor = await getDoctorById(context);

            if (doctor == null || doctor.id == null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorModal(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorPage(doctor: doctor),
                ),
              );
            }
          });
          return const SizedBox.shrink();
        },
        medicineRoute: (context) => const MedicinePage(),
        moduleRoute: (context) => const ModulePage(),
        updatePasswordRoute: (context) => UpdatePassword(),
        notFoundRoute: (context) => const Error404Screen(),
      },
    );
  }
}

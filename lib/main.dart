import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/doctor.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Login/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/ModuleAuthorization/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/PermissionAuthorization/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Register/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/UserFooter/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Doctor/DoctorModal/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Doctor/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Medicine/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Module/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/PrescriptionDetail/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/PrescriptionModal/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/index.dart';
import 'package:heart_attack_detection_fe/pages/notFound/notFound.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/doctorApi.dart';
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
      title: 'Healthcare Application',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hoverColor: Colors.white,
      ),
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
        notFoundRoute: (context) => const Error404Screen(),
        diagnosisRoute: (context) => const Prediction(),
      },
    );
  }
}

import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/patient.d.dart';

class PatientAPI {
  static Future<Patient> getPatientByAccountId(int accountId) async {
    final dio = Dio();
    final url = 'http://10.0.2.2:5000/api/patient/personal_info/account_id=$accountId';
    //127.0.0.1
    //10.0.2.2

    final response = await dio.get(url);
    final resData = response.data['data'];
    return Patient.fromMap(resData);
  }
}
import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/patient.d.dart';

class DoctorAPI {
  static Future<List<Patient>> getPatientById(id) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/patient/personal_info/patient_id=patient_id';
    
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final patient = result.map((e) {
      return Patient.fromMap(e);
    }).toList();
    return patient;
  }
}
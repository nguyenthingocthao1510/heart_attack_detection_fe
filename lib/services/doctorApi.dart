import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/doctor.d.dart';

class DoctorAPI {
  static Future<List<Doctor>> getAllDoctor() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/doctors';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final doctors = result.map((e) {
      return Doctor.fromMap(e);
    }).toList();
    return doctors;
  }
}

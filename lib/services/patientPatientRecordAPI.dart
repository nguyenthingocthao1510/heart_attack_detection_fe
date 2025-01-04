import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/patientRecord.d.dart';

class PatientPatientRecordAPI {
  static Future<patientPatientRecord> fetchOnePatientRecord(
      int accountId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/latest-patient-record/accountId=$accountId';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return patientPatientRecord.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load doctor');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching doctor');
    }
  }

  static Future<List<historyPatientPatientRecord>>
      getPatientHistoryPatientRecord(int accountId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/records/accountId=$accountId';
    final response = await dio.get(url);
    final resData = response.data['history'];
    final result = resData as List<dynamic>;
    final history = result.map((e) {
      return historyPatientPatientRecord.fromMap(e);
    }).toList();
    return history;
  }
}

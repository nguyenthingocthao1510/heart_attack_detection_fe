import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/patientRecord.d.dart';

class DoctorPatientRecordAPI {
  static Future<List<doctorPatientRecord>> getAllPatientRecord(
      int accountId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/patient-records/accountId=${accountId}';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final doctorPatientRecords = result.map((e) {
      return doctorPatientRecord.fromMap(e);
    }).toList();
    return doctorPatientRecords;
  }

  static Future<historyDoctorPatientRecord> getPatientRecordById(int id) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/patient-record/id=$id';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return historyDoctorPatientRecord.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load patient record');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching patient record');
    }
  }

  static Future<List<historyDoctorPatientRecord>> getHistoryPatientRecord(
      int accountId, int patient_id) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/patient-history-records/accountId=$accountId/patientId=$patient_id';
    final response = await dio.get(url);
    final resData = response.data['history'];
    final result = resData as List<dynamic>;
    final history = result.map((e) {
      return historyDoctorPatientRecord.fromMap(e);
    }).toList();
    return history;
  }

  static Future<historyDoctorPatientRecord> createPatientRecord(
    int? account_id,
    int? age,
    int? caa,
    int? chol,
    String? cp,
    String? create_date,
    int? doctor_id,
    String? exng,
    int? fbs,
    double? oldpeak,
    int? patient_id,
    int? restecg,
    String? sex,
    String? slp,
    int? thalachh,
    String? thall,
    int? trtbps,
  ) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/patient-records/add';
    try {
      final payload = {
        'doctor_id': doctor_id,
        'patient_id': patient_id,
        'account_id': account_id,
        'age': age,
        'trtbps': trtbps,
        'chol': chol,
        'thalachh': thalachh,
        'oldpeak': oldpeak,
        'sex': sex,
        'exng': exng,
        'caa': caa,
        'cp': cp,
        'fbs': fbs,
        'restecg': restecg,
        'slp': slp,
        'thall': thall,
        'create_date': create_date,
      };

      final response = await dio.post(url, data: payload);

      if (response.statusCode == 200) {
        print('Create patient record information successful');
        return historyDoctorPatientRecord.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to create patient record information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to create patient record information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to create patient record information due to an unexpected error');
    }
  }

  static Future<historyDoctorPatientRecord> updatePatientRecord(
    int? id,
    int age,
    int trtbps,
    int chol,
    int thalachh,
    double oldpeak,
    String sex,
    String exng,
    int caa,
    String cp,
    int fbs,
    int restecg,
    String slp,
    String thall,
  ) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/patient-record/update/id=$id';

    try {
      final payload = {
        'age': age,
        'trtbps': trtbps,
        'chol': chol,
        'thalachh': thalachh,
        'oldpeak': oldpeak,
        'sex': sex,
        'exng': exng,
        'caa': caa,
        'cp': cp,
        'fbs': fbs,
        'restecg': restecg,
        'slp': slp,
        'thall': thall,
      };

      final response = await dio.put(url, data: payload);

      if (response.statusCode == 200) {
        print('Update patient record information successful');
        return historyDoctorPatientRecord.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to update patient record information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to update patient record information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to update patient record information due to an unexpected error');
    }
  }
}

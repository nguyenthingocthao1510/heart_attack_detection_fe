import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.dart';
import 'package:heart_attack_detection_fe/services/baseApi.dart';

class DiagnosisHistoryApi extends BaseApi {
  Future<DiagnosisResult> addDiagnosisHistory(DiagnosisResult result) async {
    final jsonData = result.toJson();
    try {
      final response = await dio.post(getEndpoint('/patient/add-diagnosis-history'), data: jsonData);

      if (response.statusCode == 200 && response.data != null) {
        return DiagnosisResult.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to display result');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error status code: ${e.message}');
      } else {
        throw Exception(
            'An error occurred: ${e.message}');
      }
    } catch (e) {
      print('Save diagnosis history data: $e.response.data');
      throw Exception(
          'An error occurred in save diagnosis history: $e');
    }
  }

  Future<History> getAllHistory(int patientId) async {
    final dio = Dio();
    try {
      final response = await dio.get(getEndpoint('/patient/get-history/patient_id=$patientId'));

      if (response.statusCode == 200 && response.data != null) {
        return History.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to display result');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error status code: ${e.message}');
      } else {
        throw Exception(
            'An error occurred: ${e.message}');
      }
    } catch (e) {
      print('Save diagnosis history data: $e.response.data');
      throw Exception(
          'An error occurred in save diagnosis history: $e');
    }
  }
}


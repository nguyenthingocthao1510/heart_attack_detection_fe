import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.dart';
import 'package:heart_attack_detection_fe/services/baseApi.dart';

class PredictAPI extends BaseApi {
  Future<DiagnosisResult> predict() async {
    final dio = Dio();
    try {
      final response = await dio.post(getEndpoint('/patient/manual/diagnosis'));

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
      print('Data: $e.response.data');
      throw Exception(
          'An error occurred: $e');
      }
  }

}


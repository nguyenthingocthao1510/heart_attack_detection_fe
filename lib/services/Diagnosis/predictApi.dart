import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.d.dart';

class PredictAPI {
  static Future<DiagnosisResult> predict() async {
    final Logger log = Logger('PredictAPI');
    final dio = Dio();
    try {
      final response = await dio.post(
        'http://10.0.2.2:5000/api/patient/manual/diagnosis'
      );
      //https://heart-attack-detection-be.onrender.com/api/patient/diagnosis
      //127.0.0.1 10.0.2.2

      if (response.statusCode == 200 && response.data != null) {
        log.fine('Prediction result: $response');
        return DiagnosisResult.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to display result');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log.severe('Response code: ${e.response?.statusCode}', e);
        log.severe('Response data: ${e.response?.data}', e);
        throw Exception(
            'Error status code: ${e.message}');
      } else {
        log.severe('Error sending request: ${e.message}', e);
        throw Exception(
            'An error occurred: ${e.message}');
      }
    } catch (e) {
      log.severe('Error: $e', e);
      throw Exception(
          'An error occurred: $e');
      }
  }
}


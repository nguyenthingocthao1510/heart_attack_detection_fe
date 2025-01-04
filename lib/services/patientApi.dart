import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:heart_attack_detection_fe/models/patient.d.dart';
import 'baseApi.dart';

class PatientAPI extends BaseApi {
  Future<Patient> getPatientByAccountId(int accountId) async {
    final dio = Dio();
    final response = await dio.get(getEndpoint('/patient/personal_info/account_id=$accountId'));
    final resData = response.data['data'];
    return Patient.fromMap(resData);
  }

  Future<dynamic> toggleAutoPrediction(int id, String need_prediction) async {
    final Logger log = Logger('toggleAutoPrediction');
    final dio = Dio();
    final payload = {
      'need_prediction': need_prediction,
      'id': id
    };
    try {
      final response = await dio.put(getEndpoint('/patient/update-need-prediction'), data: payload);

      if (response.statusCode == 200 && response.data != null) {
        return response.data.toString();
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
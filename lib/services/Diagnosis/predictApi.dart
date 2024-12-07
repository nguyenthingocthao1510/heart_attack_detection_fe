import 'package:dio/dio.dart';

class PredictAPI {
  static Future<String> predict() async {
    final dio = Dio();
    try {
      final response = await dio.post(
        'http://127.0.0.1:5000/api/patient/diagnosis'
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['prediction'].toString();
      } else {
        return 'Prediction failed: Unexpected response format';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Response code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        return 'Prediction failed: ${e.response?.data}';
      } else {
        print('Error sending request: ${e.message}');
        return 'Prediction failed: ${e.message}';
      }
    } catch (e) {
      print('Error: $e');
      return 'Prediction failed: $e';
    }
  }
}

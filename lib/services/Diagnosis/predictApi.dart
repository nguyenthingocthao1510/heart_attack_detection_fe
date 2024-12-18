import 'package:dio/dio.dart';

class PredictAPI {
  static Future<String> predict() async {
    final dio = Dio();
    try {
      final response = await dio.post(
        'http://10.0.2.2:5000/api/patient/manual/diagnosis'
      );
      //https://heart-attack-detection-be.onrender.com/api/patient/diagnosis
      //127.0.0.1 10.0.2.2

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

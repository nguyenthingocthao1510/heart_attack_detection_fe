import 'package:dio/dio.dart';
import '../../../models/Diagnosis/diagnosis.d.dart';

class ReceiveUserInputAPI {
  static Future<String> receiveUserInput(Diagnosis input) async {
    final dio = Dio();
    try {
      final Map<String, dynamic> payload = input.toJson();
      final response = await dio.post(
        'http://127.0.0.1:5000/api/patient/manual/receive-user-data',
        //10.0.2.2  127.0.0.1
        data: payload,
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['data'].toString();
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

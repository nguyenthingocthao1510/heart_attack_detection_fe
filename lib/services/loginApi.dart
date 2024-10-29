import 'package:dio/dio.dart';

class LoginAPI {
  static Future<dynamic> login(String username, password) async {
    final dio = Dio();
    try {
      final Map<String, dynamic> payload = {
        'username': username,
        'password': password,
      };

      final response =
          await dio.post('http://127.0.0.1:5000/api/login', data: payload);
      // Use for phone
      // final response =
      // await dio.post('http://10.0.2.2:5000/api/login', data: payload);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.statusCode);
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw e;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to login: $e');
    }
  }
}

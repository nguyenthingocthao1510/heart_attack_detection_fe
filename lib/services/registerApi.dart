import 'package:dio/dio.dart';

class RegisterAPI {
  static Future<bool> registerUser(
      String username, String password, int roleId) async {
    final dio = Dio();
    try {
      final Map<String, dynamic> payload = {
        'username': username,
        'password': password,
        'role_id': roleId,
      };
      final url = 'http://127.0.0.1:5000/api/register';
      final response = await dio.post(url, data: payload);

      if (response.statusCode == 201) {
        print('Account created successfully');
        return true;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw e;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to register: $e');
    }
  }
}

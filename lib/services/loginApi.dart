import 'package:dio/dio.dart';

class LoginAPI {
  static Future<dynamic> login(String username, String password) async {
    final dio = Dio();
    try {
      final Map<String, dynamic> payload = {
        'username': username,
        'password': password,
      };

      final response =
          await dio.post('http://127.0.0.1:5000/api/login', data: payload);
      // final response = await dio.post('https://heart-attack-detection-be.onrender.com/api/login', data: payload);

      if (response.statusCode == 200) {
        final data = response.data;

        final roleId = data['roleId'].toString();

        return {
          'roleId': roleId,
        };
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to login: $e');
    }
  }
}

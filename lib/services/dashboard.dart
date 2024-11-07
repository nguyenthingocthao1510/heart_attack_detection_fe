import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';

class DashboardAPI {
  static Future<List<Dashboard>> getHeartRate() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/heartbeat';
    final response = await dio.get(url);
    final resData = response.data;

    // Check if resData is a list
    if (resData is List) {
      // Map each item in the list to a Dashboard object
      return resData.map((item) => Dashboard.fromMap(item)).toList();
    } else {
      // Handle unexpected response structure
      throw Exception('Unexpected response format: ${resData}');
    }
  }

  static Future<List<Dashboard>> getTemperature() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/temperature';
    final response = await dio.get(url);
    final resData = response.data;

    if (resData is List) {
      return resData.map((item) => Dashboard.fromMap(item)).toList();
    } else {
      throw Exception('Unexpected response format: ${resData}');
    }
  }
}

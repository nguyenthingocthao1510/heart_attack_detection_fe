import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';

class PatientDashboardAPI {
  static Future<List<Dashboard>> getAllAvgBPM() async {
    final Dio dio = Dio();
    final url = 'http://127.0.0.1:5000/api/avg-BPM';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final results = resData as List<dynamic>;
    final avgBPM = results.map((e) {
      return Dashboard.fromMap(e);
    }).toList();
    return avgBPM;
  }

  static Future<List<Dashboard>> getAllECG() async {
    final Dio dio = Dio();
    final url = 'http://127.0.0.1:5000/api/heartbeat';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final results = resData as List<dynamic>;
    final ecg = results.map((e) {
      return Dashboard.fromMap(e);
    }).toList();
    return ecg;
  }

  static Future<List<Dashboard>> getAllBPM() async {
    final Dio dio = Dio();
    final url = 'http://127.0.0.1:5000/api/heartbeat';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final results = resData as List<dynamic>;
    final bpm = results.map((e) {
      return Dashboard.fromMap(e);
    }).toList();
    return bpm;
  }
}

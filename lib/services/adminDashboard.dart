import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/adminDashboard.d.dart';

class AdminDashboardAPI {
  static Future<List<MedicineChart>> getAllMedicineInfo() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/dashboard/medicine-information';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final medicinesChart = resData as List<dynamic>;
    final result = medicinesChart.map((e) => MedicineChart.fromMap(e)).toList();
    return result;
  }

  static Future<AccountChart> getAccountActiveChart() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/dashboard/account-activate';
    final response = await dio.get(url);
    final resData = response.data['data'];
    if (resData != null) {
      final result = AccountChart.fromMap(resData);
      return result;
    }

    throw Exception("Failed to load active account data");
  }

  static Future<AccountChart> getAccountInactiveChart() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/dashboard/account-deactivate';
    final response = await dio.get(url);
    final resData = response.data['data'];
    if (resData != null) {
      final result = AccountChart.fromMap(resData);
      return result;
    }

    throw Exception("Failed to load active account data");
  }

  static Future<DeviceChart> getDeviceChart() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/dashboard/device-assign';
    final response = await dio.get(url);
    final resData = response.data['data'];
    if (resData != null) {
      final result = DeviceChart.fromMap(resData);
      return result;
    }

    throw Exception("Failed to load active device data");
  }

  static Future<DeviceChart> getDeviceNotAssignChart() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/dashboard/device-not-assign';
    final response = await dio.get(url);
    final resData = response.data['data'];
    if (resData != null) {
      final result = DeviceChart.fromMap(resData);
      return result;
    }

    throw Exception("Failed to load active device data");
  }
}

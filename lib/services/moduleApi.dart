import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/module.d.dart';

class ModuleAPI {
  static Future<List<Module>> fetchAllModule() async {
    final dio = Dio();
    const url = 'https://heart-attack-detection-be.onrender.com/api/modules';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final results = resData as List<dynamic>;
    final modules = results.map((e) {
      return Module.fromMap(e);
    }).toList();
    return modules;
  }
}

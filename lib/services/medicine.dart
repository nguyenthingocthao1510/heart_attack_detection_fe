import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/medicine.d.dart';

class MedicineAPI {
  static Future<List<Medicine>> getAllMedicine() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/medicines';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final medicines = result.map((e) {
      return Medicine.fromMap(e);
    }).toList();
    return medicines;
  }
}

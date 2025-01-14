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

  static Future<Medicine> getMedicineById(int medicineId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/medicine/id=${medicineId}';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Medicine.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load medicine');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching medicine');
    }
  }

  static Future<Medicine> createMedicine(
    String name,
    String uses,
    String description,
  ) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/medicine/create-information';

    try {
      final payload = {
        'name': name,
        'uses': uses,
        'description': description,
      };

      final response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        print('Create medicine information success');
        return Medicine.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to create medicine information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to create doctor information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to create doctor information due to an unexpected error');
    }
  }

  static Future<Medicine> updateMedicine(
    int? id,
    String name,
    String uses,
    String description,
  ) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/medicine/update-information/id=${id}';

    try {
      final payload = {'name': name, 'uses': uses, 'description': description};

      final response = await dio.put(url, data: payload);

      if (response.statusCode == 200) {
        print('Update medicine information successful');
        return Medicine.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to update medicine information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to update medicine information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to update medicine information due to an unexpected error');
    }
  }

  static Future<List<Medicine>> filterMedicine(String? name) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/medicine/list-medicines';
    final payload = {'name': name};
    final response = await dio.post(url, data: payload);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final modules = result.map((e) {
      return Medicine.fromMap(e);
    }).toList();
    return modules;
  }
}

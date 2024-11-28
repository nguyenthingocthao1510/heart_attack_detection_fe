import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/module.d.dart';

class ModuleAPI {
  static Future<List<Module>> fetchAllModule() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/modules';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final results = resData as List<dynamic>;
    final modules = results.map((e) {
      return Module.fromMap(e);
    }).toList();
    return modules;
  }

  static Future<Module> getModuleById(int moduleId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/module/id=${moduleId}';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Module.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load module');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching module');
    }
  }

  static Future<Module> createModule(
    String name,
    String route,
    String image,
  ) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/module/add';

    try {
      final payload = {
        'name': name,
        'route': route,
        'image': image,
      };

      final response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        print('Create module information success');
        return Module.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to create module information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to create module information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to create module information due to an unexpected error');
    }
  }

  static Future<Module> updateModule(
    int? id,
    String name,
    String route,
    String image,
  ) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/module/update/id=${id}';

    try {
      final payload = {'name': name, 'route': route, 'image': image};

      final response = await dio.put(url, data: payload);

      if (response.statusCode == 200) {
        print('Update module information successful');
        return Module.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to update module information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to update module information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to update module information due to an unexpected error');
    }
  }
}

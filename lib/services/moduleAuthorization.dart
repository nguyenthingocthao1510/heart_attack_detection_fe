import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/moduleAuthorization.d.dart';

class ModuleRoleAPI {
  static Future<List<ModuleRole>> getAllModuleInRole(int roleId) async {
    final dio = Dio();
    final url = 'http://10.0.2.2:5000/api/module-in-role/roleId=$roleId';
    //10.0.2.2  127.0.0.1
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final moduleAuthorizations = result.map((e) {
      return ModuleRole.fromMap(e);
    }).toList();
    return moduleAuthorizations;
  }

  static Future<List<ModuleRole>> getAllModuleNotInRole(int roleId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/module-not-in-role/roleId=$roleId';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final moduleAuthorizations = result.map((e) {
      return ModuleRole.fromMap(e);
    }).toList();
    return moduleAuthorizations;
  }

  static Future<Response> addModule(
      List<int> selectedModuleIds, int roleId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/add-module-to-role';
    try {
      final Map<String, dynamic> payload = {
        'module_ids': selectedModuleIds,
        'role_id': roleId,
      };
      final response = await dio.post(url, data: payload);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.statusCode}');
        print('Response: ${e.response?.data}');
      } else {
        print('Error sending message: ${e.message}');
      }
      throw e;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to add module: $e');
    }
  }

  static Future<Response> removeModule(
      List<int> selectedModuleIds, int roleId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/remove-module-in-role';
    try {
      final Map<String, dynamic> payload = {
        'module_ids': selectedModuleIds,
        'role_id': roleId,
      };
      final response = await dio.delete(url, data: payload);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.statusCode}');
        print('Response: ${e.response?.data}');
      } else {
        print('Error sending message: ${e.message}');
      }
      throw e;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to add module: $e');
    }
  }
}

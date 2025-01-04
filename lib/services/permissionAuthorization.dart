import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/permissionAuthorization.dart';

class PermissionAuthorizationAPI {
  static Future<List<PermissionAuthorization>> getAllPermissionInModuleRole(
      int roleId, int moduleId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/permission-in-role-module/roleId=$roleId/moduleId=$moduleId';

    final response = await dio.get(url);
    final resData = response.data['data'];

    final result = resData as List<dynamic>;
    final permissionAuthorizations = result.map((e) {
      return PermissionAuthorization.fromMap(e);
    }).toList();

    return permissionAuthorizations;
  }

  static Future<List<PermissionAuthorization>> getAllPermissionNotInModuleRole(
      int roleId, int moduleId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/permission-not-in-role-module/roleId=$roleId/moduleId=$moduleId';

    final response = await dio.get(url);
    final resData = response.data['data'];

    final result = resData as List<dynamic>;
    final permissionAuthorizations = result.map((e) {
      return PermissionAuthorization.fromMap(e);
    }).toList();

    return permissionAuthorizations;
  }

  static Future<Response> addPermission(
      List<int> selectedPermissionIds, int roleId, int moduleId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/add-permission-to-role-module';

    try {
      final Map<String, dynamic> payload = {
        'permission_ids': selectedPermissionIds,
        'role_id': roleId,
        'module_id': moduleId,
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
      print('Error $e');
      throw Exception('Failed to add permission: $e}');
    }
  }

  static Future<Response> removePermission(
      List<int> selectedPermissionIds, int roleId, int moduleId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/remove-permission-from-role-module';

    try {
      final Map<String, dynamic> payload = {
        'permission_ids': selectedPermissionIds,
        'role_id': roleId,
        'module_id': moduleId,
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
      print('Error $e');
      throw Exception('Failed to add permission: $e}');
    }
  }

  static Future<PermissionModule> loadAllPermission(int roleId) async {
    final dio = Dio();
    final url = 'http://10.0.2.2:5000/api/get-all-permission/roleId=$roleId';
    //127.0.0.1
    //10.0.2.2

    final response = await dio.get(url);

    if (response.data is Map<String, dynamic>) {
      final resData = response.data as Map<String, dynamic>;
      final permissionModule = PermissionModule.fromJson(resData);
      return permissionModule;
    } else {
      throw Exception('Invalid data format');
    }
  }
}

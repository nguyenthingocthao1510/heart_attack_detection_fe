import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/role.dart';

class RoleAPI {
  static Future<dynamic> getAllRole() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/roles';
    final response = await dio.get(url);
    final resData = response.data['data'];
    print('Resdata: $resData');
    final results = resData as List<dynamic>;
    final roles = results.map((e) {
      return Role.fromMap(e);
    }).toList();
    return roles;
  }

  static Future<Map<String, String>?> getRoleByAccount(int accountId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/account-role/accountId=$accountId';
    final response = await dio.get(url);

    final data = response.data;

    if (data != null && data['data']['name'] != null) {
      return {
        'id': data['data']['id'].toString(),
        'name': data['data']['name'].toString(),
      };
    } else {
      return null;
    }
  }
}

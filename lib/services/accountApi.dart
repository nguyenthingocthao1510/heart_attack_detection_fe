import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/account.d.dart';

class AccountAPI {
  static Future<dynamic> fetchAccount() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/accounts';

    final response = await dio.get(url);
    final resData = response.data['data'];

    final results = resData as List<dynamic>;
    final accounts = results.map((e) {
      return Account.fromMap(e);
    }).toList();

    return accounts;
  }

  static Future<Account> changePassword(
      String? userPassword, String? accountStatus, int? id) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/update-password/id=${id}';

    try {
      final payload = {
        'user_password': userPassword,
        'account_status': accountStatus
      };

      final response = await dio.put(url, data: payload);

      if (response.statusCode == 200) {
        print('Update password information successful');
        return Account.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to update password information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to update password information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to update password information due to an unexpected error');
    }
  }

  Future<List<Account>> filterAccount(String? username) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/account/list-accounts';
    final payload = {'username': username};
    final response = await dio.post(url, data: payload);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final modules = result.map((e) {
      return Account.fromMap(e);
    }).toList();
    return modules;
  }
}

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
}

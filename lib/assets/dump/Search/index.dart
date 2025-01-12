import 'package:dio/dio.dart';

class Search {
  int? id;
  String? name;
  String? route;
  String? image;

  Search({
    this.id,
    this.name,
    this.route,
    this.image,
  });

  factory Search.fromMap(Map<String, dynamic> e) {
    return Search(
      id: e['id'],
      name: e['name'],
      route: e['route'],
      image: e['image'],
    );
  }
}

class SearchAPI {
  static Future<List<Search>> getAllInformation(String? name) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/list-module';
    final payload = {
      'name': name,
    };
    final response = await dio.post(url, data: payload);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final modules = result.map((e) {
      return Search.fromMap(e);
    }).toList();
    return modules;
  }
}

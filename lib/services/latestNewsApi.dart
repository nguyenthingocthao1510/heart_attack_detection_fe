import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/latestNews.d.dart';

class LatestNewsAPI {
  static Future<List<LatestNews>> fetchAllNews() async {
    final dio = Dio();
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=e9887424debb455594908fa5e8ce3560';
    final response = await dio.get(url);
    final resData = response.data['articles'];
    final results = resData as List<dynamic>? ?? [];

    final latestNews = results.map((e) => LatestNews.fromMap(e)).toList();

    return latestNews;
  }
}

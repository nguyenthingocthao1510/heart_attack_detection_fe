import 'package:dio/dio.dart';

abstract class BaseApi {
  String prefixURL = ChangePrefixURL.apiPrefix;
  Dio dio = Dio();
  BaseApi();
  String getEndpoint(String postfixURL) => '$prefixURL$postfixURL';
}

class ChangePrefixURL {
  static late String apiPrefix;
  static void setApiPrefix(int choice) {
    switch (choice) {
      case 1:
        apiPrefix = 'http://127.0.0.1:5000/api';
        break;
      case 2:
        apiPrefix = 'http://10.0.2.2:5000/api';
        break;
      case 3:
        apiPrefix = 'https://heart-attack-detection-be.onrender.com/api';
        break;
      case 4:
        apiPrefix = 'https://heart-attack-detection-be-5sf2.onrender.com/api';
        break;
      default:
        throw Exception('Unknown environment: $choice');
    }
  }
}



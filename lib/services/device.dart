import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/Device/device.dart';
import 'package:heart_attack_detection_fe/services/baseApi.dart';
import 'package:logging/logging.dart';

class DeviceApi extends BaseApi {
  Future<Device> getAllDevice() async {
    final log = Logger('getAllHistory');
    try {
      final response = await dio.get(getEndpoint('/get-device'));
      if (response.statusCode == 200 && response.data != null) {
        return Device.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch device data!');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error status code: ${e.message}');
      } else {
        throw Exception(
            'An error occurred: ${e.message}');
      }
    } catch (e) {
      log.finest('An error occurred in save diagnosis history: $e');
      throw Exception(
          'An error occurred in save diagnosis history: $e');
    }
  }
}


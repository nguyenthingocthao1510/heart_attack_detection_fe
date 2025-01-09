import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/Device/device.dart';
import 'package:heart_attack_detection_fe/services/baseApi.dart';

class DeviceApi extends BaseApi {
  Future<Device> getAllDevice() async {
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
      throw Exception(
          'An error occurred in save diagnosis history: $e');
    }
  }

  Future<UnassignedPatient> getAllUnassignedPatient() async {
    try {
      final response = await dio.get(getEndpoint('/unassigned-patients'));
      if (response.statusCode == 200 && response.data != null) {
        return UnassignedPatient.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch unassigned data!');
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
      throw Exception(
          'An error occurred: $e');
    }
  }

  Future<AssignDevice> updateDeviceAssignment(String device_id, AssignDevice patient_id) async {
    try {
      final jsonData = patient_id.toJson();
      final response = await dio.put(getEndpoint('/update-device-assignment/device_id=$device_id'), data: jsonData);
      if (response.statusCode == 200 && response.data != null) {
        return AssignDevice.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch unassigned data!');
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
      throw Exception(
          'An error occurred: $e');
    }
  }
}


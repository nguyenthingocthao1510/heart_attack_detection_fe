import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/doctor.d.dart';

class DoctorAPI {
  static Future<List<Doctor>> getAllDoctor() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/doctors';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final doctors = result.map((e) {
      return Doctor.fromMap(e);
    }).toList();
    return doctors;
  }

  static Future<Doctor> getDoctorById(int? accountId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/doctor/accountId=$accountId';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Doctor.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load doctor');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching doctor');
    }
  }

  static Future<Doctor> createDoctor(
      String name,
      int account_id,
      String dob,
      int gender,
      String specialization,
      String email,
      String address,
      int age) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/doctor/create-information';

    try {
      final payload = {
        'name': name,
        'account_id': account_id,
        'dob': dob,
        'gender': gender,
        'specialization': specialization,
        'email': email,
        'address': address,
        'age': age
      };

      final response = await dio.post(url, data: payload);

      if (response.statusCode == 200) {
        print('Create doctor information successful');
        return Doctor.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to create doctor information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to create doctor information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to create doctor information due to an unexpected error');
    }
  }

  static Future<Doctor> updateDoctor(
      int? id,
      String name,
      String dob,
      int gender,
      String specialization,
      String email,
      String address,
      int age) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/doctor/update-information/doctorId=${id}';

    try {
      final payload = {
        'name': name,
        'dob': dob,
        'gender': gender,
        'specialization': specialization,
        'email': email,
        'address': address,
        'age': age
      };

      final response = await dio.put(url, data: payload);

      if (response.statusCode == 200) {
        print('Update doctor information successful');
        return Doctor.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to update doctor information ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to update doctor information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to update doctor information due to an unexpected error');
    }
  }
}

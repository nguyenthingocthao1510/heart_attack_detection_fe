import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/healthInsurance.dart';

class HealthInsuranceAPI {
  static Future<List<HealthInsurance>> getAllHealthInsurance(
      int accountId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/health-insurances/accountId=$accountId';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final healthInsurances = result.map((e) {
      return HealthInsurance.fromMap(e);
    }).toList();
    return healthInsurances;
  }

  static Future<HealthInsurance> getHealthInsuranceById(int id) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/health-insurance/id=$id';
    final response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        return HealthInsurance.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load health insurance');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching health insurance');
    }
  }

  static Future<HealthInsurance> createHealthInsurance(
      int patient_id,
      int account_id,
      String registration_place,
      String shelf_life,
      String five_years_insurance,
      String place_provide,
      String create_date,
      String modified_by,
      String health_insurance_id) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/health-insurance/add';
    try {
      final payload = {
        'patient_id': patient_id,
        'account_id': account_id,
        'registration_place': registration_place,
        'shelf_life': shelf_life,
        'five_years_insurance': five_years_insurance,
        'place_provide': place_provide,
        'create_date': create_date,
        'modified_by': modified_by,
        'health_insurance_id': health_insurance_id,
      };

      final response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        print('Create health insurance success');
        return HealthInsurance.fromMap(response.data);
      } else {
        throw Exception('Failed to create health insurance');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to create health insurance information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to create health insurance information due to an unexpected error');
    }
  }

  static Future<HealthInsurance> updateHealthInsurance(
      String? registration_place,
      String? shelf_life,
      String? five_years_insurance,
      String? place_provide,
      String? create_date,
      String? modified_by,
      String? health_insurance_id,
      int? id) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/health-insurance/update/id=$id';
    try {
      final payload = {
        'registration_place': registration_place,
        'shelf_life': shelf_life,
        'five_years_insurance': five_years_insurance,
        'place_provide': place_provide,
        'create_date': create_date,
        'modified_by': modified_by,
        'health_insurance_id': health_insurance_id
      };

      final response = await dio.put(url, data: payload);
      if (response.statusCode == 200) {
        print('Update health insurance success!');
        return HealthInsurance.fromMap(response.data);
      } else {
        throw Exception('Failed to update health insurance');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw Exception(
          'Failed to update health insurance information due to DioException');
    } catch (e) {
      throw Exception(
          'Failed to update health insurance information due to an unexpected error');
    }
  }

  static Future<PatientHealthInsurance> getPatientByAccountId(
      int? accountId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/get-all-patient/account_id=$accountId';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return PatientHealthInsurance.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load patient');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching patient');
    }
  }

  static Future<void> deleteHealthInsurance(int id) async {
    final dio = Dio();
    final String url =
        'http://127.0.0.1:5000/api/health-insurance/delete/id=$id';

    try {
      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        print('Health insurance deleted successfully');
      } else {
        throw Exception('Failed to delete health insurance');
      }
    } catch (e) {
      throw Exception('Error deleting health insurance: $e');
    }
  }
}

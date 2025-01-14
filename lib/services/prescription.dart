import 'package:dio/dio.dart';
import 'package:heart_attack_detection_fe/models/prescription.d.dart';

class PrescriptionAPI {
  static Future<List<Prescription>> getAllPrescription(int accountId) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/prescriptions/accountId=$accountId';

    try {
      final response = await dio.get(url);
      final resData = response.data['data'];

      print('response $response');

      final result = resData as List<dynamic>;
      final prescriptions = result.map((e) {
        return Prescription.fromMap(e);
      }).toList();
      return prescriptions;
    } catch (e) {
      print('Error fetching prescriptions: $e');
      throw Exception('Error fetching prescriptions');
    }
  }

  static Future<Prescription> getPrescriptionId(
      int accountId, int prescriptionId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/prescription/accountId=$accountId/prescriptionId=$prescriptionId';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return Prescription.fromMap(response.data['data']);
      } else {
        throw Exception('Failed to load prescription');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching prescription');
    }
  }

  static Future<Prescription> createPrescription(
    int patientId,
    String prescriptionDate,
    int doctorId,
    String note,
    List<Map<String, dynamic>> details,
  ) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/prescription/create-prescription';

    try {
      for (var detail in details) {
        if (!detail.containsKey('medicine_id') ||
            !detail.containsKey('medicine_amount') ||
            !detail.containsKey('usage_instructions')) {
          throw Exception("Missing required fields in detail");
        }
      }

      final payload = {
        'patient_id': patientId,
        'prescription_date': prescriptionDate,
        'doctor_id': doctorId,
        'note': note,
        'details': details,
      };

      final response = await dio.post(url, data: payload);

      if (response.statusCode == 200) {
        print('Create prescription success');
        return Prescription.fromMap(response.data);
      } else {
        throw Exception(
            'Failed to create prescription: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw e;
    }
  }

  static Future<void> updatePrescriptionDetails(
      int prescriptionId, List<Map<String, dynamic>> details) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/prescription/update-prescription/$prescriptionId';

    try {
      final response = await dio.put(url, data: {'details': details});

      if (response.statusCode == 200) {
        print('Prescription details updated successfully');
      } else {
        throw Exception('Failed to update prescription details');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
      throw e;
    }
  }

  static Future<List<PatientPrescription>> getAllPatientPrescription(
      int patientId) async {
    final dio = Dio();
    final url =
        'http://127.0.0.1:5000/api/prescriptions/patientId=${patientId}';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final patientPrescriptions = result.map((e) {
      return PatientPrescription.fromMap(e);
    }).toList();

    return patientPrescriptions;
  }

  static Future<List<DoctorPrescription>> getAllDoctorPrescription() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/prescription/doctors';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final doctorPrescriptions = result.map((e) {
      return DoctorPrescription.fromMap(e);
    }).toList();

    return doctorPrescriptions;
  }

  static Future<List<MedicinePrescription>> getAllMedicinePrescription() async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/prescription/medicines';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final medicinePrescriptions = result.map((e) {
      return MedicinePrescription.fromMap(e);
    }).toList();

    return medicinePrescriptions;
  }

  static Future<List<Prescription>> filterPrescription(
      int? account_id, String? patient_name) async {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000/api/prescription/list-prescriptions';
    final payload = {
      'account_id': account_id,
      'patient_name': patient_name,
    };
    final response = await dio.post(url, data: payload);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    final modules = result.map((e) {
      return Prescription.fromMap(e);
    }).toList();
    return modules;
  }
}

import 'package:intl/intl.dart';

class Prescription {
  int? account_id;
  String? doctor_name;
  String? note;
  int? patient_id;
  String? patient_name;
  String? prescription_date;
  int? prescription_id;
  int? doctor_id;
  List<MedicineDetail>? details;

  Prescription({
    this.prescription_id,
    this.patient_id,
    this.patient_name,
    this.doctor_name,
    this.prescription_date,
    this.note,
    this.account_id,
    this.doctor_id,
    this.details,
  });

  factory Prescription.fromMap(Map<String, dynamic> e) {
    var detailsList = e['details'] as List?;
    List<MedicineDetail> details = [];

    if (detailsList != null) {
      print('detailsList: $detailsList');
      details = detailsList.map((i) => MedicineDetail.fromMap(i)).toList();
    } else {
      print('No details available');
    }

    return Prescription(
      account_id: e['account_id'],
      doctor_name: e['doctor_name'],
      note: e['note'],
      patient_id: e['patient_id'],
      patient_name: e['patient_name'],
      prescription_date: e['prescription_date'],
      prescription_id: e['prescription_id'],
      doctor_id: e['doctor_id'],
      details: details,
    );
  }

  factory Prescription.fromJson(Map<String, dynamic> e) {
    return Prescription.fromMap(e);
  }
}

class MedicineDetail {
  int? id;
  int? medicine_id;
  int? medicine_amount;
  String? usage_instructions;

  MedicineDetail({
    this.id,
    this.medicine_id,
    this.medicine_amount,
    this.usage_instructions,
  });

  factory MedicineDetail.fromMap(Map<String, dynamic> e) {
    return MedicineDetail(
      id: e['id'],
      medicine_id: e['medicine_id'],
      medicine_amount: e['medicine_amount'],
      usage_instructions: e['usage_instructions'],
    );
  }
}

class DoctorPrescription {
  int? id;
  String? name;

  DoctorPrescription({this.id, this.name});

  factory DoctorPrescription.fromMap(Map<String, dynamic> e) {
    return DoctorPrescription(id: e['id'], name: e['name']);
  }
}

class MedicinePrescription {
  int? id;
  String? name;

  MedicinePrescription({this.id, this.name});

  factory MedicinePrescription.fromMap(Map<String, dynamic> e) {
    return MedicinePrescription(id: e['id'], name: e['name']);
  }
}

class PatientPrescription {
  int? doctor_id;
  int? medicine_amount;
  int? medicine_id;
  String? note;
  int? patient_id;
  DateTime? prescription_date;
  int? prescription_id;
  String? usage_instructions;

  PatientPrescription({
    this.doctor_id,
    this.medicine_amount,
    this.medicine_id,
    this.note,
    this.patient_id,
    this.prescription_date,
    this.prescription_id,
    this.usage_instructions,
  });

  factory PatientPrescription.fromMap(Map<String, dynamic> e) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr == null) return null;
      try {
        return DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parseUtc(dateStr);
      } catch (_) {
        print('Error parsing date: $dateStr');
        return null;
      }
    }

    return PatientPrescription(
      doctor_id: e['doctor_id'],
      medicine_amount: e['medicine_amount'],
      medicine_id: e['medicine_id'],
      note: e['note'],
      patient_id: e['patient_id'],
      prescription_date: parseDate(e['prescription_date']),
      prescription_id: e['prescription_id'],
      usage_instructions: e['usage_instructions'],
    );
  }
}

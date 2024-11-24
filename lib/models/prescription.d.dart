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

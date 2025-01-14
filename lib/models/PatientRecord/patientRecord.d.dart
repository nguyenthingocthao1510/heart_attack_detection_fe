// DOCTOR
class doctorPatientRecord {
  int? id;
  int? account_id;
  int? doctor_id;
  String? dob;
  String? gender;
  String? name;
  int? patient_record_id;

  doctorPatientRecord({
    this.id,
    this.account_id,
    this.doctor_id,
    this.dob,
    this.gender,
    this.name,
    this.patient_record_id,
  });

  factory doctorPatientRecord.fromMap(Map<String, dynamic> e) {
    return doctorPatientRecord(
      id: e['id'],
      account_id: e['account_id'],
      doctor_id: e['doctor_id'],
      dob: e['dob'],
      gender: e['gender'],
      name: e['name'],
      patient_record_id: e['patient_record_id'],
    );
  }
}

//HISTORY PATIENT RECORD
class historyDoctorPatientRecord {
  int? account_id;
  int? age;
  int? caa;
  int? chol;
  String? cp;
  String? create_date;
  int? doctor_id;
  String? exng;
  int? fbs;
  int? id;
  double? oldpeak;
  int? patient_id;
  int? restecg;
  String? sex;
  String? slp;
  int? thalachh;
  String? thall;
  int? trtbps;

  historyDoctorPatientRecord({
    this.account_id,
    this.age,
    this.caa,
    this.chol,
    this.cp,
    this.create_date,
    this.doctor_id,
    this.exng,
    this.fbs,
    this.id,
    this.oldpeak,
    this.patient_id,
    this.restecg,
    this.sex,
    this.slp,
    this.thalachh,
    this.thall,
    this.trtbps,
  });

  factory historyDoctorPatientRecord.fromMap(Map<String, dynamic> e) {
    return historyDoctorPatientRecord(
      account_id: e['account_id'],
      age: e['age'],
      caa: e['caa'],
      chol: e['chol'],
      cp: e['cp'],
      create_date: e['create_date'],
      doctor_id: e['doctor_id'],
      exng: e['exng'],
      fbs: e['fbs'],
      id: e['id'],
      oldpeak: e['oldpeak'],
      patient_id: e['patient_id'],
      restecg: e['restecg'],
      sex: e['sex'],
      slp: e['slp'],
      thalachh: e['thalachh'],
      thall: e['thall'],
      trtbps: e['trtbps'],
    );
  }
}

//PATIENT
class patientPatientRecord {
  int? account_id;
  String? address;
  int? age;
  String? dob;
  String? email;
  int? gender;
  int? id;
  String? name;
  String? specialization;

  patientPatientRecord({
    this.account_id,
    this.address,
    this.age,
    this.dob,
    this.email,
    this.gender,
    this.id,
    this.name,
    this.specialization,
  });

  factory patientPatientRecord.fromMap(Map<String, dynamic> e) {
    return patientPatientRecord(
      account_id: e['account_id'],
      address: e['address'],
      age: e['age'],
      dob: e['dob'],
      email: e['email'],
      gender: e['gender'],
      id: e['id'],
      name: e['name'],
      specialization: e['specialization'],
    );
  }
}

class historyPatientPatientRecord {
  int? account_id;
  int? age;
  int? caa;
  int? chol;
  String? cp;
  String? create_date;
  int? doctor_id;
  String? exng;
  int? fbs;
  int? id;
  double? oldpeak;
  int? patient_id;
  int? restecg;
  String? sex;
  String? slp;
  int? thalachh;
  String? thall;
  int? trtbps;

  historyPatientPatientRecord({
    this.account_id,
    this.age,
    this.caa,
    this.chol,
    this.cp,
    this.create_date,
    this.doctor_id,
    this.exng,
    this.fbs,
    this.id,
    this.oldpeak,
    this.patient_id,
    this.restecg,
    this.sex,
    this.slp,
    this.thalachh,
    this.thall,
    this.trtbps,
  });

  factory historyPatientPatientRecord.fromMap(Map<String, dynamic> e) {
    return historyPatientPatientRecord(
      account_id: e['account_id'],
      age: e['age'],
      caa: e['caa'],
      chol: e['chol'],
      cp: e['cp'],
      create_date: e['create_date'],
      doctor_id: e['doctor_id'],
      exng: e['exng'],
      fbs: e['fbs'],
      id: e['id'],
      oldpeak: e['oldpeak'],
      patient_id: e['patient_id'],
      restecg: e['restecg'],
      sex: e['sex'],
      slp: e['slp'],
      thalachh: e['thalachh'],
      thall: e['thall'],
      trtbps: e['trtbps'],
    );
  }
}

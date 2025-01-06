import 'package:intl/intl.dart';

class HealthInsurance {
  int? id;
  int? patient_id;
  int? account_id;
  String? registration_place;
  DateTime? shelf_life;
  DateTime? five_years_insurance;
  String? place_provide;
  DateTime? create_date;
  String? modified_by;
  String? health_insurance_id;
  String? name;

  HealthInsurance({
    this.id,
    this.patient_id,
    this.account_id,
    this.registration_place,
    this.shelf_life,
    this.five_years_insurance,
    this.place_provide,
    this.create_date,
    this.modified_by,
    this.health_insurance_id,
    this.name,
  });

  factory HealthInsurance.fromMap(Map<String, dynamic> e) {
    DateFormat format = DateFormat('EEE, dd MMM yyyy HH:mm:ss z');

    return HealthInsurance(
      id: e['id'],
      patient_id: e['patient_id'],
      account_id: e['account_id'],
      registration_place: e['registration_place'],
      shelf_life:
          e['shelf_life'] != null ? format.parse(e['shelf_life']) : null,
      five_years_insurance: e['five_years_insurance'] != null
          ? format.parse(e['five_years_insurance'])
          : null,
      place_provide: e['place_provide'],
      create_date:
          e['create_date'] != null ? format.parse(e['create_date']) : null,
      modified_by: e['modified_by'],
      health_insurance_id: e['health_insurance_id'],
      name: e['name'],
    );
  }
}

class PatientHealthInsurance {
  final int? id;

  PatientHealthInsurance({this.id});

  factory PatientHealthInsurance.fromMap(Map<String, dynamic> map) {
    return PatientHealthInsurance(
      id: map['id'],
    );
  }
}

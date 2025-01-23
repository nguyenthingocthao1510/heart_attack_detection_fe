import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/PatientRecord/patientRecord.d.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/doctorPatientRecordAPI.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class PatientRecordModal extends StatefulWidget {
  final int? patientRecordId;
  final historyDoctorPatientRecord? patientRecord;
  final int? doctorId;

  const PatientRecordModal(
      {super.key, this.patientRecordId, this.patientRecord, this.doctorId});

  @override
  State<PatientRecordModal> createState() => _PatientRecordModalState();
}

class _PatientRecordModalState extends State<PatientRecordModal> {
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

  @override
  void initState() {
    super.initState();

    if (widget.patientRecord != null) {
      final patientRecords = widget.patientRecord;
      id = patientRecords?.id;
      age = patientRecords?.age;
      cp = patientRecords?.cp;
      caa = patientRecords?.caa;
      chol = patientRecords?.chol;
      doctor_id = patientRecords?.doctor_id;
      create_date = patientRecords?.create_date.toString();
      exng = patientRecords?.exng;
      fbs = patientRecords?.fbs;
      oldpeak = patientRecords?.oldpeak;
      patient_id = patientRecords?.patient_id;
      restecg = patientRecords?.restecg;
      sex = patientRecords?.sex;
      slp = patientRecords?.slp;
      thalachh = patientRecords?.thalachh;
      thall = patientRecords?.thall;
      trtbps = patientRecords?.trtbps;
      print('Doctor id in if: ${patientRecords?.doctor_id}');
    } else {
      doctor_id = widget.doctorId;

      create_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }

    account_id = int.parse(
        Provider.of<AccountProvider>(context, listen: false).accountId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.patientRecord == null
            ? 'Create patient record'
            : 'Update patient record'),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('Doctor ID:', doctor_id, (value) {
                    doctor_id = int.parse(value);
                  }, isEnabled: false),
                  _buildTextField('Patient ID:', patient_id, (value) {
                    patient_id = int.tryParse(value);
                  }, isEnabled: widget.patientRecord == null),
                  _buildTextField('Age:', age, (value) {
                    age = int.tryParse(value);
                  }),
                  _buildRadioButtons(
                    'Number of major vessels:',
                    ['0', '1', '2', '3'],
                    caa.toString(),
                    (value) {
                      setState(() {
                        caa = int.parse(value!);
                      });
                    },
                  ),
                  _buildTextField('Cholesterol:', chol, (value) {
                    chol = int.tryParse(value);
                  }),
                  _buildRadioButtons(
                    'Chest pain type:',
                    [
                      'None',
                      'Typical angina',
                      'Atypical angina',
                      'Non-anginal pain',
                      'Asymptomatic'
                    ],
                    cp,
                    (value) {
                      setState(() {
                        cp = value;
                      });
                    },
                  ),
                  _buildRadioButtons(
                    'Exercise induced angina:',
                    ['No', 'Yes'],
                    exng,
                    (value) {
                      setState(() {
                        exng = value;
                      });
                    },
                  ),
                  _buildTextField('Fasting blood sugar:', fbs, (value) {
                    fbs = int.tryParse(value);
                  }),
                  _buildTextField('Old Peak:', oldpeak, (value) {
                    oldpeak = double.tryParse(value);
                  }),
                  _buildRadioButtons(
                    'Resting Electrocardiograph result:',
                    ['0', '1', '2', '3'],
                    restecg.toString(),
                    (value) {
                      setState(() {
                        restecg = int.parse(value!);
                      });
                    },
                  ),
                  _buildRadioButtons(
                    'Gender:',
                    ['Male', 'Female'],
                    sex,
                    (value) {
                      setState(() {
                        sex = value;
                      });
                    },
                  ),
                  _buildRadioButtons(
                    'Slope:',
                    ['None', 'Upsloping', 'Flat', 'Asymptomatic'],
                    slp,
                    (value) {
                      setState(() {
                        slp = value;
                      });
                    },
                  ),
                  _buildTextField('Heart Rate:', thalachh, (value) {
                    thalachh = int.tryParse(value);
                  }),
                  _buildRadioButtons(
                    'Thalium Stress Test Result:',
                    ['None', 'Normal', 'Fixed defect', 'Reversible defect'],
                    thall,
                    (value) {
                      setState(() {
                        thall = value;
                      });
                    },
                  ),
                  _buildTextField('Resting Blood Pressure:', trtbps, (value) {
                    trtbps = int.tryParse(value);
                  }),
                  _buildTextField('Create Date:', create_date, (value) {
                    create_date = value;
                  }, isEnabled: false),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _savePatientRecord,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blueAccent)),
                      child: Text(
                          widget.patientRecord == null
                              ? 'Create Record'
                              : 'Update Record',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, dynamic initialValue, Function(String) onChanged,
      {bool isEnabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          onChanged: onChanged,
          controller:
              TextEditingController(text: initialValue?.toString() ?? ''),
          enabled: isEnabled,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRadioButtons(String label, List<String> options,
      String? selectedValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedValue,
            onChanged: onChanged,
          );
        }).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  void _savePatientRecord() async {
    try {
      List<String> missingFields = [];
      if (account_id == null) missingFields.add('account_id');
      if (age == null) missingFields.add('age');
      if (caa == null) missingFields.add('caa');
      if (chol == null) missingFields.add('chol');
      if (cp == null) missingFields.add('cp');
      if (create_date == null) missingFields.add('create_date');
      if (doctor_id == null) missingFields.add('doctor_id');
      if (exng == null) missingFields.add('exng');
      if (fbs == null) missingFields.add('fbs');
      if (oldpeak == null) missingFields.add('oldpeak');
      if (patient_id == null) missingFields.add('patient_id');
      if (restecg == null) missingFields.add('restecg');
      if (sex == null) missingFields.add('sex');
      if (slp == null) missingFields.add('slp');
      if (thalachh == null) missingFields.add('thalachh');
      if (thall == null) missingFields.add('thall');
      if (trtbps == null) missingFields.add('trtbps');

      if (missingFields.isNotEmpty) {
        print('Missing fields: ${missingFields.join(', ')}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Please enter all required information! Missing: ${missingFields.join(', ')}'),
          ),
        );
        return;
      }

      if (widget.patientRecord == null) {
        await DoctorPatientRecordAPI.createPatientRecord(
          account_id,
          age,
          caa,
          chol,
          cp,
          create_date,
          doctor_id,
          exng,
          fbs,
          oldpeak,
          patient_id,
          restecg,
          sex,
          slp,
          thalachh,
          thall,
          trtbps,
        );
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Patient record created successfully!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, patientRecordRoute);
          },
        );
      } else {
        if (id == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Patient ID is missing!')),
          );
          return;
        }

        await DoctorPatientRecordAPI.updatePatientRecord(
          id,
          age!,
          trtbps!,
          chol!,
          thalachh!,
          oldpeak!,
          sex!,
          exng!,
          caa!,
          cp!,
          fbs!,
          restecg!,
          slp!,
          thall!,
        );
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Patient record updated successfully!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, patientRecordRoute);
          },
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong! Please try again.',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, doctorRoute);
        },
      );
    }
  }
}

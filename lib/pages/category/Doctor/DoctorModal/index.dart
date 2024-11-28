import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/doctor.d.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/doctorApi.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class DoctorModal extends StatefulWidget {
  final Doctor? doctor;

  const DoctorModal({this.doctor, super.key});

  @override
  State<DoctorModal> createState() => _DoctorModalState();
}

class _DoctorModalState extends State<DoctorModal> {
  int? id;
  int? accountId;
  String? name;
  int? age;
  int? gender;
  String? specialization;
  String? email;
  String? address;
  String? dob;

  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.doctor != null) {
      final doctor = widget.doctor!;
      id = doctor.id;
      name = doctor.name;
      age = doctor.age;
      gender = doctor.gender;
      specialization = doctor.specialization;
      email = doctor.email;
      address = doctor.address;
      dob = doctor.dob;
      _dobController.text = dob ?? '';
    }

    accountId = int.parse(
        Provider.of<AccountProvider>(context, listen: false).accountId ?? '0');
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(picked);
        _dobController.text = dob!;
      });
    }
  }

  Future<void> _saveDoctor() async {
    try {
      if (name == null ||
          dob == null ||
          specialization == null ||
          email == null ||
          address == null ||
          age == null ||
          gender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter information!')),
        );
        return;
      }

      final parsedDob =
          DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parse(dob!);

      final formattedDob = DateFormat('yyyy-MM-dd').format(parsedDob);

      if (widget.doctor == null) {
        await DoctorAPI.createDoctor(
          name!,
          accountId!,
          formattedDob,
          gender!,
          specialization!,
          email!,
          address!,
          age!,
        );
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Doctor created successfully!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, doctorRoute);
          },
        );
      } else {
        if (id == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Doctor ID is missing!')),
          );
          return;
        }

        await DoctorAPI.updateDoctor(
          id!,
          name!,
          formattedDob,
          gender!,
          specialization!,
          email!,
          address!,
          age!,
        );
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Doctor updated successfully!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, doctorRoute);
          },
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, doctorRoute);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.doctor == null ? 'Create Doctor' : 'Edit Doctor'),
        centerTitle: true,
      ),
      body: Container(
          color: Color(0xFFF5F6FA),
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
                    Row(
                      children: [
                        const Icon(Icons.person, size: 30, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  name = value;
                                },
                                cursorColor: Colors.black,
                                cursorWidth: 0.5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                  ),
                                ),
                                controller: TextEditingController(text: name),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month,
                            size: 30, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Date of birth',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              TextField(
                                controller: _dobController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                cursorColor: Colors.black,
                                cursorWidth: 0.5,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_today),
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.redAccent, Colors.lightBlue],
                          ).createShader(bounds),
                          child: const Icon(
                            Icons.transgender,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                        'Male',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      leading: Radio<int>(
                                        fillColor: MaterialStatePropertyAll(
                                            Colors.blue),
                                        activeColor: Colors.green,
                                        value: 0,
                                        groupValue: gender,
                                        onChanged: (int? value) {
                                          setState(() {
                                            gender = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                        'Female',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      leading: Radio<int>(
                                        fillColor: MaterialStatePropertyAll(
                                            Colors.blue),
                                        value: 1,
                                        groupValue: gender,
                                        onChanged: (int? value) {
                                          setState(() {
                                            gender = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.mail, size: 30, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                cursorColor: Colors.black,
                                cursorWidth: 0.5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                  ),
                                ),
                                controller: TextEditingController(text: email),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 30, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Age',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  age = int.tryParse(value);
                                },
                                cursorColor: Colors.black,
                                cursorWidth: 0.5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                  ),
                                ),
                                controller: TextEditingController(
                                    text: age?.toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.home, size: 30, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Address',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  address = value;
                                },
                                cursorColor: Colors.black,
                                cursorWidth: 0.5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                  ),
                                ),
                                controller:
                                    TextEditingController(text: address),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.assignment_ind,
                            size: 30, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ).createShader(bounds),
                                child: const Text(
                                  'Specialization',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  specialization = value;
                                },
                                cursorColor: Colors.black,
                                cursorWidth: 0.5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue),
                                  ),
                                ),
                                controller:
                                    TextEditingController(text: specialization),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveDoctor,
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue)),
                        child: Text(
                          widget.doctor == null
                              ? 'Create information'
                              : 'Update information',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

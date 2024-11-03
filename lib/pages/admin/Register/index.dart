import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/role.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/registerApi.dart';
import 'package:heart_attack_detection_fe/services/role.dart';
import 'package:quickalert/quickalert.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int activeStep = 0;
  String? username;
  String? password;
  String? confirmPassword;
  int? roleId;
  bool passwordVisible = false;
  List<Role> roles = [];
  String? dropdownValue;
  int reachedStep = 0;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllRole();
  }

  Future<void> getAllRole() async {
    final response = await RoleAPI.getAllRole();
    setState(() {
      roles = response;
    });
  }

  void onChangeDropDown(String? value) {
    setState(() {
      dropdownValue = value;
      if (value != null) {
        roleId = int.parse(value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  bool _allowTabStepping(int index, StepEnabling enabling) {
    return enabling == StepEnabling.sequential
        ? index <= reachedStep
        : reachedSteps.contains(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, homePage),
          ),
        ),
        title: const Text("Register account"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EasyStepper(
              activeStep: activeStep,
              maxReachedStep: reachedStep,
              lineStyle: LineStyle(
                lineLength: 120,
                lineSpace: 4,
              ),
              activeStepBorderColor: Colors.white,
              activeStepIconColor: Colors.white,
              activeStepTextColor: Colors.blueAccent,
              activeStepBackgroundColor: Colors.blueAccent,
              unreachedStepBackgroundColor: Colors.grey.withOpacity(0.5),
              unreachedStepBorderColor: Colors.grey.withOpacity(0.5),
              unreachedStepIconColor: Colors.grey,
              unreachedStepTextColor: Colors.grey.withOpacity(0.5),
              finishedStepBackgroundColor: Colors.green,
              finishedStepBorderColor: Colors.grey.withOpacity(0.5),
              finishedStepIconColor: Colors.white,
              finishedStepTextColor: Colors.blueAccent,
              internalPadding: 15,
              borderThickness: 3,
              showLoadingAnimation: false,
              steps: [
                EasyStep(
                  icon: const Icon(Icons.create),
                  title: 'Register',
                  lineText: 'Processing register',
                  enabled: _allowTabStepping(0, StepEnabling.sequential),
                ),
                EasyStep(
                  icon: const Icon(Icons.check_circle_outline),
                  title: 'Finish',
                  enabled: _allowTabStepping(5, StepEnabling.sequential),
                ),
              ],
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            _buildInputField(
              label: 'Username',
              hintText: 'Enter username',
              onChanged: (value) => setState(() => username = value),
            ),
            _buildPasswordField(
              label: 'Password',
              hintText: 'Enter Password',
              onChanged: (value) => setState(() => password = value),
            ),
            _buildPasswordField(
              label: 'Confirm Password',
              hintText: 'Enter Confirm Password',
              onChanged: (value) {
                setState(() => confirmPassword = value);

                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(seconds: 2), () {
                  if (password != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                  }
                });
              },
              isConfirmPassword: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Role'),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Role',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      items: roles.map((Role role) {
                        return DropdownMenuItem<String>(
                          value: role.id.toString(),
                          child: Text(
                            role.name!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      value: dropdownValue,
                      onChanged: onChangeDropDown,
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 300,
                height: 45,
                child: TextButton(
                  onPressed: _handleRegister,
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required Function(String) onChanged,
    bool isConfirmPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15)),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (username == null ||
        username!.isEmpty ||
        password == null ||
        password!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    if (password != confirmPassword) {
      _showErrorAlert("Passwords do not match");
      return;
    }

    try {
      final response =
          await RegisterAPI.registerUser(username!, password!, roleId!);

      if (response != null) {
        setState(() {
          activeStep = 1;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Registration Successful!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, homePage);
          },
        );
      }
    } catch (error) {
      _showErrorAlert(error.toString());
    }
  }

  void _showErrorAlert(String errorMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: errorMessage,
    );
  }
}

enum StepEnabling { sequential, individual }

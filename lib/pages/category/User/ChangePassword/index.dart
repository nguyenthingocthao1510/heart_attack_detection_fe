import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/accountApi.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? password;
  String? confirmPassword;
  String accountStatus = 'Active'; // Default account status
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPasswordField(
              label: 'Password',
              hintText: 'Enter Password',
              onChanged: (value) => setState(() => password = value),
              isConfirmPassword: false,
            ),
            _buildPasswordField(
              label: 'Confirm Password',
              hintText: 'Enter Confirm Password',
              onChanged: (value) {
                setState(() => confirmPassword = value);
                _startDebounce();
              },
              isConfirmPassword: true,
            ),
            _buildStatusDropdown(),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 45,
              child: TextButton(
                onPressed: _handleChangePassword,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                child: const Text(
                  'Update password',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
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
            obscureText:
                isConfirmPassword ? !confirmPasswordVisible : !passwordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  (isConfirmPassword ? confirmPasswordVisible : passwordVisible)
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirmPassword) {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    } else {
                      passwordVisible = !passwordVisible;
                    }
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status'),
          DropdownButtonFormField<String>(
            value: accountStatus,
            items: ['Active', 'Inactive']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                accountStatus = value!;
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startDebounce() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), _validatePasswords);
  }

  void _validatePasswords() {
    if (password != null && confirmPassword != null) {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showErrorAlert(String errorMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: errorMessage,
    );
  }

  Future<void> _handleChangePassword() async {
    String? accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId;
    if (password == null || password!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (confirmPassword == null || confirmPassword!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Confirm Password cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await AccountAPI.changePassword(
        password!,
        accountStatus,
        int.parse(accountId!),
      );

      if (response != null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Password updated successfully!',
          onConfirmBtnTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        );
      } else {
        _showErrorAlert('Failed to update password');
      }
    } catch (error) {
      _showErrorAlert('Error: ${error.toString()}');
    }
  }
}

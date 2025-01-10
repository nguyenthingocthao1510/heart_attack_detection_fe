import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/models/permissionAuthorization.dart';
import 'package:heart_attack_detection_fe/pages/category/User/Support/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/loginApi.dart';
import 'package:heart_attack_detection_fe/services/patientApi.dart';
import 'package:heart_attack_detection_fe/services/permissionAuthorization.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String? username;
  String? password;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnOpacity: 0.1,
            spawnMinSpeed: 150.0,
            spawnMinRadius: 1.0,
            spawnMaxSpeed: 300.0,
            spawnMaxRadius: 5.0,
            minOpacity: 0.1,
            maxOpacity: 0.1,
            baseColor: Colors.blue,
          ),
        ),
        vsync: this,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.only(top: 100, bottom: 20),
                child: Image.asset(healthCareIcon),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username:'),
                    SizedBox(height: 8),
                    TextField(
                      cursorColor: Colors.black,
                      cursorWidth: 1.0,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter username',
                      ),
                      onChanged: (usernameValue) {
                        setState(() {
                          username = usernameValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password:'),
                    SizedBox(height: 8),
                    TextField(
                      cursorColor: Colors.black,
                      cursorWidth: 1.0,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        alignLabelWithHint: false,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter Password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onChanged: (passwordValue) {
                        setState(() {
                          password = passwordValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: TextButton(
                  onPressed: onForgetPassword,
                  child: Text(
                    'Forget password',
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 3),
                child: SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      if (username == null ||
                          username!.isEmpty ||
                          password == null ||
                          password!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Please enter both username and password'),
                          ),
                        );
                      } else {
                        onLogin(username!, password!);
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onLogin(String username, String password) async {
    try {
      LoginAPI loginAPI = LoginAPI();
      final response = await loginAPI.login(username, password);
      if (response != null) {
        String roleId = response['roleId'];
        String accountId = response['accountId'];
        PermissionAuthorizationAPI permissionAuthorizationAPI =
            PermissionAuthorizationAPI();
        final permissionResponse = await permissionAuthorizationAPI
            .loadAllPermission(int.parse(roleId));

        if (permissionResponse is PermissionModule) {
          final permissionProvider =
              Provider.of<PermissionProvider>(context, listen: false);
          permissionProvider.updatePermissionsFromApi(permissionResponse);

          print('Permissions: ${permissionProvider.permissions}');
          print('Role ID: ${permissionProvider.roleId}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login success')),
          );
          Provider.of<AccountProvider>(context, listen: false)
              .setAccountId(accountId);
        if (roleId == '3') {
            PatientAPI patientAPI = PatientAPI();
            var patientData = await patientAPI.getPatientByAccountId(accountId);
            Provider.of<PatientProvider>(context, listen: false)
                .setPatient(patientData);
        } 

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login success')),
        );
        Navigator.pushNamed(context, homePage, arguments: roleId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login fail')),
        );
      }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  void onForgetPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Support()));
  }
}

import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/loginApi.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              margin: EdgeInsets.only(top: 100, bottom: 20),
              child: Image.asset(healthCareIcon),
            ),
            Container(
              alignment: Alignment.centerLeft, // Aligns text to the left
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username:',
                  ),
                  SizedBox(height: 8),
                  TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter username',
                      ),
                      onChanged: (usernamevalue) {
                        setState(() {
                          username = usernamevalue;
                          print('UN: $username');
                        });
                      }),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft, // Aligns text to the left
              padding: EdgeInsets.symmetric(horizontal: 25),
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password:',
                  ),
                  SizedBox(height: 8),
                  TextField(
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
                          }),
                      alignLabelWithHint: false,
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
                        print('PW: $password');
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
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: () => onLogin(username!, password!),
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
                      ))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username or password is missing!')));
      return;
    }

    try {
      final response = await LoginAPI.login(username, password);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login success')));
        Navigator.pushNamed(context, homePage);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login fail')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username or password may not correct')));
    }
  }

  void onForgetPassword() {}
}

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/loginApi.dart';

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
          title: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
            spawnOpacity: 0.1,
            spawnMinSpeed: 150.0,
            spawnMinRadius: 1.0,
            spawnMaxSpeed: 300.0,
            spawnMaxRadius: 5.0,
            minOpacity: 0.1,
            maxOpacity: 0.1,
            baseColor: Colors.blue,
          )),
          vsync: this,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  margin: const EdgeInsets.only(top: 100, bottom: 20),
                  child: Image.asset(healthCareIcon),
                ),
                Container(
                  alignment: Alignment.centerLeft, // Aligns text to the left
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username:',
                      ),
                      const SizedBox(height: 8),
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
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft, // Aligns text to the left
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password:',
                      ),
                      const SizedBox(height: 8),
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
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: TextButton(
                      onPressed: onForgetPassword,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        'Forget password',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  child: SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () => {
                        if (username == null ||
                            username!.isEmpty ||
                            password == null ||
                            password!.isEmpty)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter both username and password')),
                            )
                          }
                        else
                          {onLogin(username!, password!)}
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.blue),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ))),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> onLogin(String? username, String? password) async {
    try {
      final response = await LoginAPI.login(username!, password);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login success')),
        );
        Navigator.pushNamed(context, homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login fail')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  void onForgetPassword() {}
}

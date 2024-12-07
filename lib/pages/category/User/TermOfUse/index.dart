import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';

class TermOfUse extends StatefulWidget {
  const TermOfUse({super.key});

  @override
  State<TermOfUse> createState() => _TermOfUseState();
}

class _TermOfUseState extends State<TermOfUse> {
  final controller = ScrollController();
  var isTopPosition = 0.0;

  void scrollDown() {
    final double goDown = controller.position.maxScrollExtent;
    controller.animateTo(goDown,
        duration: Duration(milliseconds: 1), curve: Curves.easeInCirc);
  }

  void scrollUp() {
    final double goUp = 0;
    controller.animateTo(goUp,
        duration: Duration(milliseconds: 1), curve: Curves.easeInCirc);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollPosition);
  }

  void scrollPosition() {
    final isTop = controller.position.pixels;
    setState(() {
      isTopPosition = isTop;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of use'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '1. User Responsibilities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'By using our healthcare application, users agree to provide accurate and complete information for the proper functioning of the app and connected IoT devices. Users are responsible for maintaining the confidentiality of their account information and ensuring all actions taken through their accounts comply with applicable laws and regulations.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '2. Data Privacy and Security',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'We prioritize the security of your personal and health data. All data collected through the application and IoT devices is encrypted and stored securely. Users consent to the collection and use of their data as outlined in our Privacy Policy, including the sharing of data with healthcare providers to improve health outcomes.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '3. Limitation of Liability',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'While we strive to provide accurate and reliable health insights through our app and IoT devices, we are not liable for any errors, omissions, or adverse outcomes resulting from the use of our services. Users should consult their healthcare providers before making any medical decisions based on the data provided by the app. Our app is not intended to replace professional medical advice, diagnosis, or treatment.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '4. Intellectual Property',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'All content, trademarks, logos, and other intellectual property displayed on the application are the property of their respective owners. Users agree not to reproduce, distribute, or create derivative works from any content provided through the application without explicit permission.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '5. Third-Party Services',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Our application may integrate with third-party services and IoT devices to enhance functionality. We are not responsible for the accuracy, reliability, or performance of these third-party services. Users agree to comply with the terms and conditions of any third-party services used in conjunction with our application.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '6. Updates and Modifications',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'We reserve the right to update, modify, or discontinue any part of the application at any time without prior notice. Users are encouraged to regularly check for updates to ensure the best possible experience. Continued use of the application after any changes signifies acceptance of those changes.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '7. Termination of Use',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'We reserve the right to terminate or restrict access to the application for any user who violates these Terms of Use or engages in activities deemed harmful or disruptive. Users may also terminate their account at any time, and all personal data will be handled in accordance with our Privacy Policy.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Accept and continue',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: isTopPosition == 0 ? scrollDown : scrollUp,
        child: isTopPosition == 0
            ? Icon(
                Icons.arrow_circle_down,
                color: Colors.white,
                size: 30,
              )
            : Icon(
                Icons.arrow_circle_up_outlined,
                color: Colors.white,
                size: 30,
              ),
      ),
    );
  }
}

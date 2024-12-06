import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final controller = ScrollController();
  var isTopPosition = 0.0;

  void scrollDown() {
    final goDown = controller.position.maxScrollExtent;
    controller.animateTo(goDown,
        duration: const Duration(microseconds: 1), curve: Curves.easeInCirc);
  }

  void scrollUp() {
    final goUp = 0.0;
    controller.animateTo(goUp,
        duration: const Duration(microseconds: 1), curve: Curves.easeInCirc);
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
        title: Text('Privacy and policy'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text:
                          '-  The integration of Internet of Things (IoT) devices in healthcare applications presents significant advancements in patient care and wellness management. However, it also raises critical ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'privacy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' concerns that must be addressed to ensure the ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'security',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'trustworthiness',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' of these technologies. This thesis explores the key privacy and policy issues associated with healthcare IoT, offering a comprehensive analysis of current practices, challenges, and future directions.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text:
                          '-  Healthcare applications that incorporate IoT devices have the potential to revolutionize ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'patient care',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' by providing ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'real-time monitoring',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'personalized treatments',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', and improved ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'health outcomes',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              '. Despite these benefits, the use of IoT in healthcare introduces complex ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'privacy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' challenges that necessitate careful consideration. This thesis aims to dissect these challenges, providing insights into how they can be managed effectively to protect ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'patient privacy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' and adhere to ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'regulatory standards',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: '.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text:
                          '-  One of the primary concerns in healthcare IoT is the ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'privacy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' of patient data. ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: ' IoT devices collect vast amounts of ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'sensitive health information',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ', which, if not properly safeguarded, could be vulnerable to breaches and misuse. Ensuring data privacy involves implementing robust ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'encryption methods',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' secure data transmission protocols, and stringent ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'access controls',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' to protect patient information from unauthorized access and cyber threats.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text:
                          '-  Healthcare applications must comply with a myriad of ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'regulations',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' that govern the use of ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'personal health data',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: '. Regulations such as the ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text:
                              'Health Insurance Portability and Accountability Act',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' (HIPAA) in the United States and the ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'General Data Protection Regulation',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' (GDPR) in Europe impose strict requirements on ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'data protection',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'consent',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'patient rights',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              '. Developers of healthcare IoT applications must ensure that their systems are designed to meet these regulatory standards, which often necessitate complex ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'data management strategies',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: '.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text:
                          '-  Obtaining informed consent is a critical aspect of using IoT devices in healthcare. Patients must be fully aware of what data is being collected, how it will be used, and who will have access to it. ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Transparent communication',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' and comprehensive consent forms are essential to ensure that patients understand their ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'right',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' and the implications of their data being collected and analyzed by IoT devices.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text:
                          '-  The integration of IoT devices in healthcare applications offers tremendous potential to improve ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'patient care',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'outcomes',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              '. However, it also necessitates a robust approach to ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'privacy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' considerations. By addressing ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'data privacy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'regulatory compliance',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'data ownership',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'security measures',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'ethical considerations',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ', stakeholders can create a trustworthy and secure environment for the use of IoT in healthcare. Moving forward, a ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'patient-centric',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ' approach that prioritizes ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'transparency',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'security',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: ', and ',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'ethical standards',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              ' will be key to the successful implementation of IoT technology in the healthcare sector.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
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
                size: 30,
                color: Colors.white,
              )
            : Icon(
                Icons.arrow_circle_up,
                size: 30,
                color: Colors.white,
              ),
      ),
    );
  }
}

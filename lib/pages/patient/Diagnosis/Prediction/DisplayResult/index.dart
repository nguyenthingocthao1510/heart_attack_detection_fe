import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_background/animated_background.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:provider/provider.dart';
import '../index.dart';

class DisplayResult extends StatefulWidget {
  final DiagnosisResult result;
  const DisplayResult({super.key, required this.result});

  @override
  State<DisplayResult> createState() => _DisplayResultState();
}

class _DisplayResultState extends State<DisplayResult> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientProvider>(context).patient;
    final int prediction = widget.result.prediction;
    Color? backgroundColor = (prediction == 0) ? Colors.green : Colors.red;
    String title = (prediction == 0) ? 'Congratulation!' : 'Warning!';
    String result = (prediction == 0) ? 'Your heart is in good shape!' : 'There is high risk of heart attack!';

    return Scaffold(
      backgroundColor: backgroundColor,
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
            baseColor: Colors.white,
          ),
        ),
        vsync: this,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultAnnouncement(title, patient, result),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Center(
              child: _buildCard(widget.result.thalachh, 'Heart rate', backgroundColor),
            ).animate()
              .fadeIn(
                delay: 400.ms,
                duration: 800.ms,
                begin: 0.1
              )
              .move(
                delay: 400.ms,
                begin: const Offset(0, 100),
                curve: Curves.easeOut,
                duration: 800.ms
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: _buildCard(widget.result.restecg, 'Electrocardiogram', backgroundColor),
            ).animate()
              .fadeIn(
                delay: 500.ms,
                duration: 800.ms,
                begin: 0.1
              )
              .move(
                delay: 500.ms,
                begin: const Offset(0, 100),
                curve: Curves.easeOut,
                duration: 800.ms
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Prediction()),
                  );
                },
                child: Text(
                  "Try again",
                  style: TextStyle(
                      color: backgroundColor
                  ),
                )
              )
            ).animate()
              .fadeIn(
                delay: 600.ms,
                duration: 800.ms,
                begin: 0.1
              )
              .move(
                delay: 600.ms,
                begin: const Offset(0, 100),
                curve: Curves.easeOut,
                duration: 800.ms
              ),
          ],
        )
      )
    );
  }

  Widget _buildResultAnnouncement(title, patient, result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05
          ),
          child: Text(title, style: CustomTextStyle.textStyle1(48, Colors.white)),
        ),
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05
          ),
          child: Text('${patient!.name}, $result', style: CustomTextStyle.textStyle2(24, Colors.white)),
        ),
        CustomDivider.divider1(context),
      ],
    ).animate()
      .fadeIn(
        duration: 600.ms,
        begin: 0.1
      )
      .move(
        duration: 600.ms,
        begin: const Offset(0, 100),
        curve: Curves.easeOut
      )
    ;
  }

  Widget _buildCard(value, parameter, Color? color) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.15,
        child: ListTile(
          title: Text(
            value.toString(),
            style: CustomTextStyle.textStyle1(56, color),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            parameter,
            style: CustomTextStyle.textStyle1(20, Colors.black),
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}


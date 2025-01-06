import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';

class AssignPatientPage extends StatefulWidget {
  const AssignPatientPage({super.key});

  @override
  State<AssignPatientPage> createState() => _AssignPatientPageState();
}

class _AssignPatientPageState extends State<AssignPatientPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Select patient to assign',
              style: CustomTextStyle.textStyle1(20, Colors.black),
            ),
            CustomDivider.divider2(context, 0.02),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.grey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                    Text('Patient'),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {

            },
              child: Text(
                'do something'
              )
            )
          ],
        ),
      )
    );
  }
}
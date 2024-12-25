import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';

class DiagnosisHistory extends StatefulWidget {
  const DiagnosisHistory({super.key});

  @override
  State<DiagnosisHistory> createState() => _DiagnosisHistoryState();
}

class _DiagnosisHistoryState extends State<DiagnosisHistory> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  // Future<> getDoctorById() async {
  //   try {
  //     final accountId =
  //         Provider.of<AccountProvider>(context, listen: false).accountId;
  //     final response = await DoctorAPI.getDoctorById(int.parse(accountId!));
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: CustomTextStyle.textStyle1(28, Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 139, 251),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Card(
            
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
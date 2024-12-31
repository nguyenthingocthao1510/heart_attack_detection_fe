import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/History/diagnosisHistoryApi.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';

class DiagnosisHistory extends StatefulWidget {
  const DiagnosisHistory({super.key});

  @override
  State<DiagnosisHistory> createState() => _DiagnosisHistoryState();
}

class _DiagnosisHistoryState extends State<DiagnosisHistory> {
  DiagnosisHistoryApi diagnosisHistoryApi = DiagnosisHistoryApi();
  Future<History>? historyFuture;

  @override
  void initState() {
    super.initState();
    historyFuture = getAllHistory();
  }

  Future<History> getAllHistory() async {
    try {
      final patientId = Provider.of<PatientProvider>(context, listen: false).patient!.id;
      return await diagnosisHistoryApi.getAllHistory(patientId);
    } catch (e) {
      rethrow;
    }
  }

  String formatDiagnosisTime(String? rawTime, String format) {
    if (rawTime == null) {
      return 'Unknown';
    }
    try {
      final inputFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz');
      final dateTime = inputFormat.parse(rawTime);
      final outputFormat = DateFormat(format);
      return outputFormat.format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }

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
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<History>(
          future: historyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final historyData = snapshot.data!.history;
              if (historyData.isEmpty) {
                return const Center(child: Text('No history available.'));
              }
              return ListView.builder(
                itemCount: historyData.length,
                itemBuilder: (context, index) {
                  final item = historyData[index];
                  final entries = item['entries'];
                  return Column(
                    children: [
                      SizedBox(height: 24,),
                      _buildHistoryLabel(context, item),
                      ...entries.map((entry) => _buildHistoryDetail(context, entry)).toList(),
                      CustomDivider.divider2(context, 0.1)
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      )
    );
  }

  Widget _buildHistoryDetail(BuildContext context, Map<String, dynamic> item) {
    final diagnosisTimeRaw = item['diagnosis_time'];
    final diagnosisTime = formatDiagnosisTime(diagnosisTimeRaw, 'hh:mm a');
    final restecg = item['restecg'];
    final thalachh = item['thalachh'];
    List texts = [diagnosisTime, 'Electrocardiograph: $restecg', 'Heart rate: $thalachh'];

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(8.0),
      elevation: 12,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...texts.map((text) => Text(
                                        text,
                                        style: text == texts[0] ? CustomTextStyle.textStyle1(24, Colors.black) : CustomTextStyle.textStyle2(16, Colors.black),
                                      )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryLabel(BuildContext context, Map<String, dynamic> item) {
    final date = item['date'];
    final diagnosisTime = formatDiagnosisTime(date, 'EEEE, LLL d y');
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        diagnosisTime,
        style: CustomTextStyle.textStyle1(28, Colors.black),
      ),
    );
  }

}

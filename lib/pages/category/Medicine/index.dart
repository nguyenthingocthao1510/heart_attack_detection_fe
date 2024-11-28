import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/medicine.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Medicine/MedicineModal/index.dart';
import 'package:heart_attack_detection_fe/services/medicine.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllMedicine();
  }

  Future<void> getAllMedicine() async {
    final response = await MedicineAPI.getAllMedicine();
    setState(() {
      medicines = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Medicine'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Container(
        color: Color(0xFFF5F6FA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = medicines[index];
                      final name = medicine.name;
                      final uses = medicine.uses;
                      final description = medicine.description;

                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(name!),
                          subtitle: Text('${description} - ${uses}'),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MedicineModal(medicine: medicine),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chevron_right)),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicineModal()),
          );
        },
        icon: Icon(Icons.add),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            iconColor: WidgetStatePropertyAll(Colors.white),
            iconSize: WidgetStatePropertyAll(35)),
      ),
    );
  }
}

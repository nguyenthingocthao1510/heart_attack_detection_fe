import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/medicine.d.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/medicine.dart';
import 'package:quickalert/quickalert.dart';

class MedicineModal extends StatefulWidget {
  final Medicine? medicine;

  const MedicineModal({super.key, this.medicine});

  @override
  State<MedicineModal> createState() => _MedicineModalState();
}

class _MedicineModalState extends State<MedicineModal> {
  late TextEditingController nameController;
  late TextEditingController usesController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
        text: widget.medicine != null ? widget.medicine!.name : '');
    usesController = TextEditingController(
        text: widget.medicine != null ? widget.medicine!.uses : '');
    descriptionController = TextEditingController(
        text: widget.medicine != null ? widget.medicine!.description : '');
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.medicine != null;
    String? name;
    String? uses;
    String? description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(isUpdate ? 'Update Medicine' : 'Add Medicine'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      cursorColor: Colors.black,
                      cursorWidth: 0.5,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                        ),
                      ),
                      controller: nameController,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Usage',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      onChanged: (value) {
                        uses = value;
                      },
                      cursorColor: Colors.black,
                      cursorWidth: 0.5,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                        ),
                      ),
                      controller: usesController,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      cursorColor: Colors.black,
                      cursorWidth: 0.5,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                        ),
                      ),
                      controller: descriptionController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue)),
                        onPressed: () {
                          if (isUpdate) {
                            // Update logic
                            updateMedicine();
                          } else {
                            // Add logic
                            addMedicine();
                          }
                        },
                        child: Text(
                          isUpdate ? 'Update medicine' : 'Add medicine',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addMedicine() async {
    try {
      if (nameController.text.isEmpty ||
          usesController.text.isEmpty ||
          descriptionController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please enter information of medicine!')));
        return;
      }

      await MedicineAPI.createMedicine(
        nameController.text,
        usesController.text,
        descriptionController.text,
      );

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Medicine created successfully!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, medicineRoute);
        },
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, doctorRoute);
        },
      );
    }
  }

  void updateMedicine() async {
    try {
      if (widget.medicine == null) {
        throw Exception('Medicine ID is missing');
      }

      await MedicineAPI.updateMedicine(
        widget.medicine!.id,
        nameController.text,
        usesController.text,
        descriptionController.text,
      );

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Medicine updated successfully!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, medicineRoute);
        },
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, doctorRoute);
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/module.d.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/moduleApi.dart';
import 'package:quickalert/quickalert.dart';

class ModuleModal extends StatefulWidget {
  final Module? module;

  const ModuleModal({super.key, this.module});

  @override
  State<ModuleModal> createState() => _ModuleModalState();
}

class _ModuleModalState extends State<ModuleModal> {
  late TextEditingController nameController;
  late TextEditingController routeController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
        text: widget.module != null ? widget.module!.name : '');
    routeController = TextEditingController(
        text: widget.module != null ? widget.module!.route : '');
    imageController = TextEditingController(
        text: widget.module != null ? widget.module!.image : '');
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.module != null;
    String? name;
    String? route;
    String? image;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(isUpdate ? 'Update module' : 'Add module'),
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
                      'Route',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      onChanged: (value) {
                        route = value;
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
                      controller: routeController,
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
                        image = value;
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
                      controller: imageController,
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
                            updateModule();
                          } else {
                            addModule();
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

  void addModule() async {
    try {
      if (nameController.text.isEmpty ||
          routeController.text.isEmpty ||
          imageController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please enter information of module!')));
        return;
      }
      ModuleAPI moduleAPI = ModuleAPI();
      await moduleAPI.createModule(
        nameController.text,
        routeController.text,
        imageController.text,
      );

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Module created successfully!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, moduleRoute);
        },
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, moduleRoute);
        },
      );
    }
  }

  void updateModule() async {
    try {
      if (widget.module == null) {
        throw Exception('Module ID is missing');
      }
      ModuleAPI moduleAPI = ModuleAPI();
      await moduleAPI.updateModule(
        widget.module!.id,
        nameController.text,
        routeController.text,
        imageController.text,
      );

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Module updated successfully!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, moduleRoute);
        },
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, moduleRoute);
        },
      );
    }
  }
}

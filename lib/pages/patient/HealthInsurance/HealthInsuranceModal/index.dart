import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/healthInsurance.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/healthInsuranceAPI.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class HealthInsuranceModal extends StatefulWidget {
  final HealthInsurance? healthInsurance;
  final int? patientId;

  const HealthInsuranceModal({super.key, this.healthInsurance, this.patientId});

  @override
  State<HealthInsuranceModal> createState() => _HealthInsuranceModalState();
}

class _HealthInsuranceModalState extends State<HealthInsuranceModal> {
  late TextEditingController placeProviderController;
  late TextEditingController registrationPlaceController;
  late TextEditingController modifiedByController;
  late TextEditingController healthInsuranceIdController;

  DateTime? shelfLife;
  DateTime? fiveYearsInsurance;
  DateTime? createDate;

  @override
  void initState() {
    super.initState();
    placeProviderController = TextEditingController(
      text: widget.healthInsurance?.place_provide ?? '',
    );
    registrationPlaceController = TextEditingController(
      text: widget.healthInsurance?.registration_place ?? '',
    );
    modifiedByController = TextEditingController(
      text: widget.healthInsurance?.modified_by ?? '',
    );
    healthInsuranceIdController = TextEditingController(
      text: widget.healthInsurance?.health_insurance_id ?? '',
    );
    shelfLife = widget.healthInsurance?.shelf_life;
    fiveYearsInsurance = widget.healthInsurance?.five_years_insurance;
    createDate = widget.healthInsurance?.create_date;
  }

  @override
  void dispose() {
    placeProviderController.dispose();
    registrationPlaceController.dispose();
    modifiedByController.dispose();
    healthInsuranceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.healthInsurance != null;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Health Insurance Detail'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField('Place Provider', placeProviderController),
                    const SizedBox(height: 10),
                    _buildTextField(
                        'Registration Place', registrationPlaceController),
                    const SizedBox(height: 10),
                    _buildTextField('Modified By', modifiedByController),
                    const SizedBox(height: 10),
                    _buildTextField(
                        'Health Insurance ID', healthInsuranceIdController),
                    const SizedBox(height: 15),
                    _buildDatePicker('Shelf Life', shelfLife,
                        (DateTime newDate) {
                      setState(() {
                        shelfLife = newDate;
                      });
                    }),
                    const SizedBox(height: 15),
                    _buildDatePicker('Five Years Insurance', fiveYearsInsurance,
                        (DateTime newDate) {
                      setState(() {
                        fiveYearsInsurance = newDate;
                      });
                    }),
                    const SizedBox(height: 15),
                    _buildDatePicker('Create Date', createDate,
                        (DateTime newDate) {
                      setState(() {
                        createDate = newDate;
                      });
                    }),
                    const SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          if (isUpdate) {
                            updateHealthInsurance();
                          } else {
                            createHealthInsurance();
                          }
                        },
                        child: Text(
                          isUpdate ? 'Update Insurance' : 'Add Insurance',
                          style: const TextStyle(color: Colors.white),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        TextField(
          controller: controller,
          cursorColor: Colors.black,
          cursorWidth: 0.5,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(
      String label, DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        InkWell(
          onTap: () async {
            final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                ) ??
                DateTime.now();

            onDateSelected(picked);
          },
          child: AbsorbPointer(
            child: TextField(
              controller: TextEditingController(
                text: selectedDate != null ? formatDate(selectedDate) : '',
              ),
              decoration: const InputDecoration(
                hintText: 'Select Date',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(date);
  }

  void createHealthInsurance() async {
    try {
      final accountId =
          Provider.of<AccountProvider>(context, listen: false).accountId;

      final placeProvide = placeProviderController.text.trim();
      if (placeProvide.isEmpty) {
        throw Exception('Place provider cannot be empty');
      }

      final DateTime shelfLifeValue = shelfLife ?? DateTime.now();
      final DateTime fiveYearsInsuranceValue =
          fiveYearsInsurance ?? DateTime.now();
      final DateTime createDateValue = createDate ?? DateTime.now();

      final String modifiedBy = modifiedByController.text.trim();
      final String healthInsuranceId = healthInsuranceIdController.text.trim();

      await HealthInsuranceAPI.createHealthInsurance(
        widget.patientId!,
        int.parse(accountId!),
        registrationPlaceController.text.trim(),
        formatDate(shelfLifeValue),
        formatDate(fiveYearsInsuranceValue),
        placeProvide,
        formatDate(createDateValue),
        modifiedBy,
        healthInsuranceId,
      );

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Health insurance insert successfully!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, healthInsuranceRoute);
        },
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, healthInsuranceRoute);
        },
      );
    }
  }

  void updateHealthInsurance() async {
    try {
      final placeProvide = placeProviderController.text.trim();
      if (placeProvide.isEmpty) {
        throw Exception('Place provider cannot be empty');
      }

      final DateTime shelfLifeValue = shelfLife ?? DateTime.now();
      final DateTime fiveYearsInsuranceValue =
          fiveYearsInsurance ?? DateTime.now();
      final DateTime createDateValue = createDate ?? DateTime.now();

      final String modifiedBy = modifiedByController.text.trim();
      final String healthInsuranceId = healthInsuranceIdController.text.trim();

      await HealthInsuranceAPI.updateHealthInsurance(
        registrationPlaceController.text.trim(),
        formatDate(shelfLifeValue),
        formatDate(fiveYearsInsuranceValue),
        placeProvide,
        formatDate(createDateValue),
        modifiedBy,
        healthInsuranceId,
        widget.healthInsurance!.id,
      );

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Health insurance updated successfully!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, healthInsuranceRoute);
        },
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Something went wrong!',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, healthInsuranceRoute);
        },
      );
    }
  }
}

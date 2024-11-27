import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:heart_attack_detection_fe/models/medicine.d.dart';
import 'package:heart_attack_detection_fe/models/prescription.d.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/medicine.dart';
import 'package:heart_attack_detection_fe/services/prescription.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class PrescriptionModal extends StatefulWidget {
  final Prescription? prescriptionData;

  PrescriptionModal({Key? key, this.prescriptionData}) : super(key: key);

  @override
  State<PrescriptionModal> createState() => _PrescriptionModalState();
}

class _PrescriptionModalState extends State<PrescriptionModal> {
  Map<String, int> selectedMedicineIds = {};
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> fieldNames = [];
  int _newTextFieldId = 0;
  DateTime selectedDate = DateTime.now();
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();

    if (widget.prescriptionData != null) {
      fieldNames.clear();
      for (var i = 0; i < widget.prescriptionData!.details!.length; i++) {
        final groupName = 'group_$i';
        fieldNames.add(groupName);

        final medicineId = widget.prescriptionData!.details![i].medicine_id;
        selectedMedicineIds[groupName] = medicineId ?? 0;
      }
    } else {
      fieldNames.add('group_${_newTextFieldId++}');
    }

    getAllMedicine();
  }

  Future<void> getAllMedicine() async {
    final response = await MedicineAPI.getAllMedicine();
    setState(() {
      medicines = response;
    });
  }

  void _addField() {
    setState(() {
      final newGroupName = 'group_${_newTextFieldId++}';
      fieldNames.add(newGroupName);
    });
  }

  void _removeField(String groupName) {
    setState(() {
      fieldNames.remove(groupName);
    });
  }

  List<Map<String, dynamic>> buildDetails() {
    final List<Map<String, dynamic>> details = [];

    for (var groupName in fieldNames) {
      final id = widget.prescriptionData
              ?.details?[int.parse(groupName.split('_')[1])].id ??
          0;

      final medicine = selectedMedicineIds[groupName] ?? 0;

      final usage = _formKey
          .currentState?.fields['${groupName}_usage_instructions']?.value;
      final amount = int.tryParse(_formKey.currentState
                  ?.fields['${groupName}_medicine_amount']?.value ??
              '') ??
          0;

      if (medicine != 0 && usage != null && amount != 0) {
        details.add({
          'id': id,
          'medicine_id': medicine,
          'medicine_amount': amount,
          'usage_instructions': usage,
        });
      }
    }

    return details;
  }

  void submitForm() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      final formDataCopy = Map<String, dynamic>.from(formData);
      formDataCopy['prescription_date'] = selectedDate.toIso8601String();

      print('formData: $formData');

      final details = buildDetails();

      if (details.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one medicine')),
        );
        return;
      }

      try {
        final response = widget.prescriptionData == null
            ? await PrescriptionAPI.createPrescription(
                int.parse(formDataCopy['patient_id']),
                selectedDate.toIso8601String(),
                int.parse(formDataCopy['doctor_id']),
                formDataCopy['note'],
                details,
              )
            : await PrescriptionAPI.updatePrescriptionDetails(
                widget.prescriptionData!.prescription_id!,
                details,
              );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Prescription ${widget.prescriptionData == null ? 'created' : 'updated'} successfully!'),
          ),
        );
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text:
              'Prescription ${widget.prescriptionData == null ? 'created' : 'updated'} successfully!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, prescription);
          },
        );
      } catch (e) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Something went wrong!',
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, prescription);
          },
        );
      }
    } else {
      print('Validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final doctorName = arguments?['doctor_name'] ?? 'Unknown Doctor';
    final doctorId = arguments?['doctor_id']?.toString() ?? 'Unknown ID';
    print('Doctor name: $doctorName');
    print('Doctor id: $doctorId');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.prescriptionData == null
            ? 'Add Prescription'
            : 'Edit Prescription'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Patient ID',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            FormBuilderTextField(
                              cursorWidth: 1.0,
                              cursorColor: Colors.blue,
                              name: 'patient_id',
                              initialValue: widget.prescriptionData?.patient_id
                                  ?.toString(),
                              enabled: widget.prescriptionData == null,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, top: 5),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Doctor',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: widget.prescriptionData == null
                                        ? Colors.black
                                        : Colors.grey,
                                    width: 0.7,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5, top: 5),
                                child: Text(
                                  widget.prescriptionData?.doctor_name ??
                                      doctorName ??
                                      '',
                                  style: TextStyle(
                                    color: widget.prescriptionData == null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Offstage(
                              offstage: true,
                              child: FormBuilderTextField(
                                cursorWidth: 1.0,
                                cursorColor: Colors.blue,
                                name: 'doctor_id',
                                initialValue: doctorId,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: widget.prescriptionData == null
                                        ? Colors.black
                                        : Colors.grey,
                                    width: 0.7,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5, top: 5),
                                child: Text(
                                  '${DateFormat('dd-MM-yyyy').format(selectedDate)}',
                                  style: TextStyle(
                                    color: widget.prescriptionData == null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: [
                                ...fieldNames.map(
                                  (groupName) {
                                    int index =
                                        int.parse(groupName.split('_')[1]);
                                    final detail = widget
                                        .prescriptionData?.details?[index];

                                    return Row(
                                      key: ValueKey(groupName),
                                      children: [
                                        Expanded(
                                          child: Autocomplete<Medicine>(
                                            optionsBuilder: (TextEditingValue
                                                textEditingValue) {
                                              if (textEditingValue
                                                  .text.isEmpty) {
                                                return const Iterable<
                                                    Medicine>.empty();
                                              }
                                              return medicines.where((Medicine
                                                      medicine) =>
                                                  medicine.name!
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase()));
                                            },
                                            displayStringForOption:
                                                (Medicine medicine) =>
                                                    medicine.name!,
                                            onSelected:
                                                (Medicine selectedMedicine) {
                                              setState(() {
                                                selectedMedicineIds[groupName] =
                                                    selectedMedicine.id!;
                                              });
                                            },
                                            fieldViewBuilder: (BuildContext
                                                    context,
                                                TextEditingController
                                                    textController,
                                                FocusNode focusNode,
                                                VoidCallback onFieldSubmitted) {
                                              final selectedMedicineId =
                                                  selectedMedicineIds[
                                                      groupName];
                                              final selectedMedicine =
                                                  medicines.firstWhere(
                                                (medicine) =>
                                                    medicine.id ==
                                                    selectedMedicineId,
                                                orElse: () =>
                                                    Medicine(id: 0, name: ''),
                                              );
                                              if (selectedMedicine
                                                  .name!.isNotEmpty) {
                                                textController.text =
                                                    selectedMedicine.name!;
                                              }

                                              return TextField(
                                                controller: textController,
                                                focusNode: focusNode,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Medicine',
                                                  floatingLabelStyle: TextStyle(
                                                      color: Colors.blue),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              );
                                            },
                                            optionsViewBuilder: (BuildContext
                                                    context,
                                                AutocompleteOnSelected<Medicine>
                                                    onSelected,
                                                Iterable<Medicine> options) {
                                              return Material(
                                                color: Colors.white,
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 0),
                                                  child: ListView.builder(
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final Medicine medicine =
                                                          options
                                                              .elementAt(index);
                                                      return ListTile(
                                                        hoverColor: Colors.grey
                                                            .withOpacity(0.1),
                                                        title: Text(
                                                            medicine.name!),
                                                        onTap: () => onSelected(
                                                            medicine),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: FormBuilderTextField(
                                            cursorColor: Colors.blue,
                                            cursorWidth: 1.0,
                                            name:
                                                '${groupName}_usage_instructions',
                                            initialValue:
                                                detail?.usage_instructions,
                                            decoration: const InputDecoration(
                                              labelText: 'Usage',
                                              floatingLabelStyle:
                                                  TextStyle(color: Colors.blue),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: FormBuilderTextField(
                                            cursorColor: Colors.blue,
                                            cursorWidth: 1.0,
                                            name:
                                                '${groupName}_medicine_amount',
                                            initialValue: detail
                                                ?.medicine_amount
                                                ?.toString(),
                                            decoration: const InputDecoration(
                                              labelText: 'Amount',
                                              floatingLabelStyle:
                                                  TextStyle(color: Colors.blue),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Visibility(
                                          visible: fieldNames.length > 1 &&
                                              groupName != 'group_0',
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.red),
                                            onPressed: () =>
                                                _removeField(groupName),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.lightBlue)),
                                  onPressed: _addField,
                                  child: const Text(
                                    'Add more detail',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Note',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            FormBuilderTextField(
                              cursorWidth: 1.0,
                              cursorColor: Colors.blue,
                              name: 'note',
                              initialValue: widget.prescriptionData?.note,
                              enabled: widget.prescriptionData == null,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, top: 5),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.lightBlue),
                                    ),
                                    onPressed: submitForm,
                                    child: Text(
                                      widget.prescriptionData == null
                                          ? 'Create'
                                          : 'Update',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

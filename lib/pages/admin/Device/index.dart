import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/models/Device/device.dart';
import 'package:heart_attack_detection_fe/services/Device/device.dart';
import 'package:heart_attack_detection_fe/pages/admin/Device/assignPatient.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  DeviceApi deviceApi = DeviceApi();
  late Future<Device> deviceFuture;
  late List<Map<String, dynamic>> filteredDevices;
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = 'All';
    deviceFuture = fetchDevices();
    filteredDevices = [];
  }

  Future<Device> fetchDevices() async {
    try {
      final response = await deviceApi.getAllDevice();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  void filterDevices(String status, List<Map<String, dynamic>> devices) {
    setState(() {
      selectedStatus = status;

      if (status == 'All') {
        filteredDevices = devices;
      } else {
        filteredDevices = devices
            .where((device) => device['status'] == status)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device',
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
        color: const Color.fromARGB(255, 238, 238, 238),
        child: FutureBuilder<Device>(
          future: deviceFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final devices = snapshot.data!.device;

              if (filteredDevices.isEmpty || selectedStatus == 'All') {
                filteredDevices = devices;
              }
              return Column(
                children: [
                  _buildRowOfChangeStateButton(devices),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDevices.length,
                      itemBuilder: (context, index) {
                        final device = filteredDevices[index];
                        final entries = device['entries'] as List;
                        return Column(
                          children: [
                            ...entries.map((entry) => _buildDeviceDetail(context, entry, device['status'])).toList(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      )
    );
  }

Widget _buildRowOfChangeStateButton(List<Map<String, dynamic>> devices) {
  List<String> types = ['All', 'Available', 'Assigned'];
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: types.map((type) {
        bool isActive = type == selectedStatus;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedStatus = type;
            });
            filterDevices(type, devices);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                alignment: Alignment.center,
                color: Colors.white,
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 16,
                    color: isActive
                        ? const Color.fromARGB(255, 20, 139, 251)
                        : Colors.black,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              Container(
                height: 3,
                constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: MediaQuery.of(context).size.width * 0.3,
                ),
                color: isActive
                  ? const Color.fromARGB(255, 20, 139, 251)
                  : Colors.transparent,
                child: IntrinsicWidth(
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}


  Widget _buildDeviceDetail(BuildContext context, Map<String, dynamic> device, type) {
    final deviceId = device['device_id'] ?? 'Unknown ID';
    final patientId = device['patient_id']?.toString() ?? 'None';

    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(8.0),
      elevation: 12,
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deviceId,
                      style: CustomTextStyle.textStyle1(16, const Color.fromARGB(255, 20, 139, 251))
                    ),
                    Text(
                        'Assigned to: $patientId',
                        style: CustomTextStyle.textStyle2(12, Colors.black)
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 20, 139, 251),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      (type == 'Available') ? Icons.person_add : Icons.person_remove,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if(type == 'Available') {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return AssignPatientPage(deviceId: device['device_id']);
                          }
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


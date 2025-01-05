import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/models/Device/device.dart';
import 'package:heart_attack_detection_fe/services/device.dart';

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
    filteredDevices = [];
    deviceFuture = fetchDevices();
  }

  Future<Device> fetchDevices() async {
    try {
      return deviceApi.getAllDevice();
    } catch (e) {
      rethrow;
    }
  }

  

  void filterDevices(String status, Device device) {
    print("response: ${deviceFuture}");
    setState(() {
      selectedStatus = status;

      if (status == 'All') {
        filteredDevices = device.device
            .expand((device) => device['entries'] as List<Map<String, dynamic>>)
            .toList();
      } else {
        filteredDevices = device.device
            .where((d) => d['status'] == status)
            .expand((d) => d['entries'] as List<Map<String, dynamic>>)
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
      body: FutureBuilder<Device>(
        future: deviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final device = snapshot.data!;

            if (filteredDevices.isEmpty || selectedStatus == 'All') {
              filteredDevices = device.device
                  .expand((d) => d['entries'] as List<Map<String, dynamic>>)
                  .toList();
            }

            return Column(
              children: [
                _buildRowOfChangeStateButton(context, device),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredDevices.length,
                    itemBuilder: (context, index) {
                      final entry = filteredDevices[index];
                      return _buildDeviceDetail(context, entry);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      )
    );
  }

  Widget _buildRowOfChangeStateButton(BuildContext context, Device device) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => filterDevices('All', device),
          child: const Text('All'),
        ),
        ElevatedButton(
          onPressed: () => filterDevices('Available', device),
          child: const Text('Available'),
        ),
        ElevatedButton(
          onPressed: () => filterDevices('Assigned', device),
          child: const Text('Assigned'),
        ),
      ],
    );
  }


  Widget _buildDeviceDetail(BuildContext context, Map<String, dynamic> device) {
    final deviceId = device['device_id'] ?? 'Unknown ID';
    final patientId = device['patient_id']?.toString() ?? 'Unassigned';

    return Card(
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
                      style: CustomTextStyle.textStyle1(
                          24, const Color.fromARGB(255, 20, 139, 251)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 16,
                          color: const Color.fromARGB(255, 20, 139, 251),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Assigned to: $patientId',
                          style: CustomTextStyle.textStyle2(16, Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Action'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


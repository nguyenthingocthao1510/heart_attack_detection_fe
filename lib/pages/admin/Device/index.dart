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
  late Future<List<Map<String, dynamic>>> deviceFuture;
  late List<Map<String, dynamic>> filteredDevices;
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = 'All';
    deviceFuture = fetchDevices();
    filteredDevices = [];
  }

  Future<List<Map<String, dynamic>>> fetchDevices() async {
    try {
      final response = await deviceApi.getAllDevice();
      return response.device;
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: deviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final devices = snapshot.data!;

            // Initialize filteredDevices for the first render
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
                          _buildDeviceDetail(context, device),
                          ...entries.map((entry) => _buildDeviceDetail(context, entry)).toList(),
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
    );
  }

  Widget _buildRowOfChangeStateButton(List<Map<String, dynamic>> devices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => filterDevices('All', devices),
          child: const Text('All'),
        ),
        ElevatedButton(
          onPressed: () => filterDevices('Available', devices),
          child: const Text('Available'),
        ),
        ElevatedButton(
          onPressed: () => filterDevices('Assigned', devices),
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


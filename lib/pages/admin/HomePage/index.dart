import 'dart:async';

import 'package:animated_background/animated_background.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/Category/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/Footer/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/SideBar/index.dart';
import 'package:heart_attack_detection_fe/providers/heartBeatProvider.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

/// HomePage Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isSidebarOpen = true;
  bool _isDialogOpen = false; // Control dialog state
  final DirectCaller directCaller = DirectCaller();
  final String emergencyNumber = '0123456';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    final heartbeatProvider =
        Provider.of<HeartbeatProvider>(context, listen: false);

    // Start fetching heartbeat data
    heartbeatProvider.startFetching();
  }

  @override
  void dispose() {
    final heartbeatProvider =
        Provider.of<HeartbeatProvider>(context, listen: false);
    heartbeatProvider.stopFetching(); // Stop fetching when leaving the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roleId = ModalRoute.of(context)?.settings.arguments as String?;
    final roleProvider = Provider.of<RoleProvider>(context);

    if (roleId != null) {
      roleProvider.setRoleId(roleId);
    }

    final heartbeatProvider = Provider.of<HeartbeatProvider>(context);
    if (heartbeatProvider.hasHighThalachh && !_isDialogOpen) {
      _isDialogOpen = true; // Prevent dialog from reopening
      Future.microtask(() => _showHighBPMDialog());
    }

    return WillPopScope(
      onWillPop: () async {
        _fetchData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, right: 10, bottom: 10),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset(icon64px),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Homepage',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.logout,
                      color: Colors.blue,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
        ),
        body: SizedBox.expand(
          child: AnimatedBackground(
            vsync: this,
            behaviour: BubblesBehaviour(
              options: const BubbleOptions(
                popRate: 1,
                minTargetRadius: 1.0,
                bubbleCount: 30,
                maxTargetRadius: 5.0,
                growthRate: 150.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                AnimatedContainer(
                  width: isSidebarOpen ? 170 : 50,
                  duration: const Duration(milliseconds: 300),
                  child: SideBar(
                    isSidebarOpen: isSidebarOpen,
                    onToggle: () {
                      setState(() {
                        isSidebarOpen = !isSidebarOpen;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width -
                        (isSidebarOpen ? 170 : 50),
                    color: const Color(0xFFF5F6FA),
                    child: const CatergoryPage(),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: FooterSection(route: homePage),
        ),
      ),
    );
  }

  void _showHighBPMDialog() {
    Timer? callTimer; // Timer để kiểm soát thời gian chờ

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Bắt đầu timer khi dialog hiển thị
        callTimer = Timer(const Duration(seconds: 10), () {
          Navigator.of(context).pop(); // Đóng dialog nếu đang mở
          _makeEmergencyCall(); // Gọi chức năng gọi khẩn cấp
        });

        return AlertDialog(
          title: const Text('High BPM Alert'),
          content: const Text(
              'We have detected a BPM > 120. If you are okay, please press the Ok button within 1 minute. If not, we will immediately contact your family.'),
          actions: [
            TextButton(
              onPressed: () {
                // Nếu người dùng nhấn OK
                callTimer?.cancel(); // Hủy Timer
                final heartbeatProvider =
                    Provider.of<HeartbeatProvider>(context, listen: false);
                heartbeatProvider.resetHighThalachh();

                setState(() {
                  _isDialogOpen = false;
                });
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        _isDialogOpen = false;
      });
      callTimer?.cancel(); // Hủy Timer nếu dialog đóng trước khi hết giờ
    });
  }

  Future<void> _makeEmergencyCall() async {
    if (await Permission.phone.request().isGranted) {
      try {
        final result = await directCaller.makePhoneCall(emergencyNumber);
        if (result) {
          print('Cuộc gọi khẩn cấp thành công đến $emergencyNumber.');
        } else {
          print('Không thể thực hiện cuộc gọi.');
        }
      } catch (e) {
        print('Lỗi khi thực hiện cuộc gọi: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to make the emergency call.'),
          ),
        );
      }
    } else {
      print('Quyền gọi điện thoại bị từ chối.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone call permission denied.'),
        ),
      );
    }
  }
}

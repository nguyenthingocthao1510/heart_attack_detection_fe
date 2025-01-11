import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/Category/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/Footer/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/SideBar/index.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String? roleId;
  bool isSidebarOpen = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    final roleId = Provider.of<RoleProvider>(context, listen: false).roleId;
    print("Fetching API for roleId: $roleId");
  }

  @override
  Widget build(BuildContext context) {
    roleId = ModalRoute.of(context)?.settings.arguments as String?;
    final roleProvider = Provider.of<RoleProvider>(context);

    roleProvider.setRoleId(roleId);

    return WillPopScope(
      onWillPop: () async {
        _fetchData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: const Text('Homepage',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 10, bottom: 10),
                child: Container(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
          child: FooterSection(route: homePage,),
        ),
      ),
    );
  }
}

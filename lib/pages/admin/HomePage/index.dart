import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/Category/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/SideBar/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isSidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: false,
      ),
      body: SizedBox.expand(
        child: AnimatedBackground(
          vsync: this,
          behaviour: BubblesBehaviour(
            options: BubbleOptions(
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
              // Sidebar
              AnimatedContainer(
                width: isSidebarOpen ? 170 : 50, // Sidebar width transitions
                duration: Duration(milliseconds: 300),
                child: SideBar(
                  isSidebarOpen: isSidebarOpen,
                  onToggle: () {
                    setState(() {
                      isSidebarOpen = !isSidebarOpen; // Toggle sidebar state
                    });
                  },
                ),
              ),
              // Main content - Category Page
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width -
                      (isSidebarOpen ? 170 : 50),
                  // Adjust width based on sidebar
                  color: Color(0xFFF5F6FA),
                  child: const CatergoryPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

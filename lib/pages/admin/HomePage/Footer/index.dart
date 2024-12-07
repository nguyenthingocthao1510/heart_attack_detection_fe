import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  int selected = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              selected = index;
            });
          },
          children: const [
            Center(child: Text('Page 1')),
            Center(child: Text('Page 2')),
            Center(child: Text('Page 3')),
          ],
        ),
        bottomNavigationBar: StylishBottomBar(
          option: AnimatedBarOptions(
            inkEffect: false,
            iconStyle: IconStyle.Default,
          ),
          items: [
            BottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              backgroundColor: Colors.blue,
            ),
            BottomBarItem(
              icon: const Icon(Icons.show_chart),
              title: const Text('Dashboard'),
              backgroundColor: Colors.blue,
            ),
            BottomBarItem(
              icon: const Icon(Icons.health_and_safety),
              title: const Text('Predict'),
              backgroundColor: Colors.blue,
            ),
            BottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Setting'),
              backgroundColor: Colors.blue,
            ),
            BottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('User'),
              backgroundColor: Colors.blue,
            ),
          ],
          hasNotch: true,
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index;
            });
            if (index == 1) {
              Navigator.pushNamed(
                  context, dashboard); // Navigate to dashboard page
            } else if (index == 2) {
              Navigator.pushNamed(context, diagnosisRoute);
            } else if (index == 4) {
              Navigator.pushNamed(context, userInformation);
            } else {
              _pageController.jumpToPage(index); // Switch between other pages
            }
          },
        ),
      ),
    );
  }
}

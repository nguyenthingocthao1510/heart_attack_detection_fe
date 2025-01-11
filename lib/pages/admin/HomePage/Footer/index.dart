import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';

class FooterSection extends StatefulWidget {
  String route;
  FooterSection({super.key, required this.route});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  int selected = 0;
  late PageController _pageController;
  MaterialColor color = Colors.grey;

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

  Map<String, dynamic> changeIcon2(int roleId) {
    switch (roleId) {
      case 1:
        return {};
      case 2:
        return {
          'icon': const Icon(CupertinoIcons.phone_solid),
          'title': const Text('Contact'),
        };
      case 3:
        return {
          'icon': const Icon(Icons.show_chart),
          'title': const Text('Dashboard'),
          'color': (widget.route == dashboard) ? Colors.blue : color
        };
      default:
        break;
    }
    return {};
  }

  Map<String, dynamic> changeIcons3(int roleId) {
    switch (roleId) {
      case 1:
        return {};
      case 2:
        return {
          'icon': Image.asset(prescriptionIcon),
          'title': const Text('Prescription'),
          'color': (widget.route == prescription) ? Colors.blue : color
        };
      case 3:
        return {
          'icon': Image.asset(
            diagnosisIcon,
            width: 25,
            height: 25,
            color: (widget.route == diagnosisRoute) ? Colors.blue : color
          ),
          'title': const Text('Diagnosis'),
          'color': (widget.route == diagnosisRoute) ? Colors.blue : color
        };
      default:
        break;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final roleId =
    int.parse(Provider.of<RoleProvider>(context, listen: false).roleId!);
    final item2 = changeIcon2(roleId);
    final item3 = changeIcons3(roleId);
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
              backgroundColor: (widget.route == homePage) ? Colors.blue : color,
            ),
            BottomBarItem(
              icon: item2['icon'] ?? const Icon(Icons.error),
              title: item2['title'] ?? const Text('Error'),
              backgroundColor: item2['color'] ?? color,
            ),
            BottomBarItem(
              icon: item3['icon'] ?? const Icon(Icons.error),
              title: item3['title'] ?? const Text('Error'),
              backgroundColor: item3['color'] ?? color,
            ),
            BottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Setting'),
              backgroundColor: color,
            ),
            BottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('User'),
              backgroundColor: color,
            ),
          ],
          hasNotch: true,
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index;
            });
            if (index == 0) {
              Navigator.pushNamed(context, homePage);
            } else if (index == 1) {
              Navigator.pushNamed(context, dashboard); // Navigate to dashboard page
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

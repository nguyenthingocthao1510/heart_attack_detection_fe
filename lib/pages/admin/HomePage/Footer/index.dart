import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:heart_attack_detection_fe/assets/color/index.dart';
import 'package:heart_attack_detection_fe/main.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';

class FooterSection extends StatefulWidget {
  FooterSection({super.key});

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

  Map<String, dynamic> change2ndIcon(int roleId) {
    switch (roleId) {
      case 1:
        return {
          'icon': const Icon(CupertinoIcons.chart_bar_alt_fill),
          'title': const Text('Dashboard'),
        };
      case 2:
        return {
          'icon': const Icon(CupertinoIcons.phone_solid),
          'title': const Text('Contact'),
        };
      case 3:
        return {
          'icon': const Icon(Icons.show_chart),
          'title': const Text('Dashboard'),
        };
      default:
        break;
    }
    return {};
  }

  Map<String, dynamic> change3rdIcon(int roleId) {
    switch (roleId) {
      case 1:
        return {
          'icon': const Icon(CupertinoIcons.waveform),
          'title': const Text('Device')
        };
      case 2:
        return {
          'icon': Image.asset(
            prescriptionIcon,
            width: 25,
            height: 25,
          ),
          'title': const Text('Prescription'),
        };
      case 3:
        return {
          'icon': Image.asset(
            diagnosisIcon,
            width: 25,
            height: 25,
          ),
          'title': const Text('Diagnosis'),
        };
      default:
        break;
    }
    return {};
  }

  Object changeNavigator(int roleId, int index) {
    switch (roleId) {
      case 1:
        if (index == 1) {
          return {};
        }
        if (index == 2) {
          return Navigator.pushNamed(context, deviceRoute);
        }
      case 2:
        if (index == 1) {
          return {};
        }
        if (index == 2) {
          return Navigator.pushNamed(context, prescription);
        }
      case 3:
        if (index == 1) {
          return Navigator.pushNamed(context, dashboard);
        }
        if (index == 2) {
          return Navigator.pushNamed(context, diagnosisRoute);
        }
      default:
        break;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final roleId =
    int.parse(Provider.of<RoleProvider>(context, listen: false).roleId!);
    final item2 = change2ndIcon(roleId);
    final item3 = change3rdIcon(roleId);
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
              selectedColor: mainColor
            ),
            BottomBarItem(
              icon: item2['icon'] ?? const Icon(Icons.error),
              title: item2['title'] ?? const Text('Error'),
              selectedColor: mainColor
            ),
            BottomBarItem(
              icon: item3['icon'] ?? const Icon(Icons.error),
              title: item3['title'] ?? const Text('Error'),
              selectedColor: mainColor
            ),
            BottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Setting'),
              selectedColor: mainColor
            ),
            BottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text('User'),
              selectedColor: mainColor
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
              changeNavigator(roleId, index);
            } else if (index == 2) {
              changeNavigator(roleId, index);
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

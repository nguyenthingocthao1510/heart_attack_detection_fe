import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/category/User/AboutUs/index.dart';
import 'package:heart_attack_detection_fe/pages/category/User/ChangePassword/index.dart';
import 'package:heart_attack_detection_fe/pages/category/User/PrivacyPolicy/index.dart';
import 'package:heart_attack_detection_fe/pages/category/User/Support/index.dart';
import 'package:heart_attack_detection_fe/pages/category/User/TermOfUse/index.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import '../HomePage/Footer/index.dart';

class UserFooterSection extends StatefulWidget {
  const UserFooterSection({super.key});

  @override
  State<UserFooterSection> createState() => _UserFooterSectionState();
}

class _UserFooterSectionState extends State<UserFooterSection> {

  void redirectTo(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6FA),
        surfaceTintColor: const Color(0xFFF5F6FA),
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(
            child: Text('User', style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.cyan, Colors.blue],
                  ),
                ),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => const RadialGradient(
                      colors: [Colors.black, Colors.blue],
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.person,
                      size: 120,
                    ),
                  ),
                ),
              ),
            ),
            _buildCard(
              context,
              'Settings',
              [
                _buildListTile(context,
                    icon: Icons.lock,
                    title: 'Change password',
                    gradientColors: [Color(0xFF614385), Color(0xFF516395)],
                    onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                }),
                _buildListTile(context,
                    icon: Icons.support_agent,
                    title: 'Support',
                    gradientColors: [Color(0xFF09203F), Color(0xFF537895)],
                    onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Support()));
                }),
              ],
            ),
            _buildCard(
              context,
              'Legal and policies',
              [
                _buildListTile(context,
                    icon: Icons.my_library_books,
                    title: 'Terms of use',
                    gradientColors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                    onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermOfUse()));
                }),
                _buildListTile(context,
                    icon: Icons.key,
                    title: 'Privacy policy',
                    gradientColors: [Color(0xFF662D8C), Color(0xFFED1E79)],
                    onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                }),
              ],
            ),
            _buildCard(
              context,
              'Information',
              [
                _buildListTile(context,
                    icon: Icons.perm_device_information,
                    title: 'About us',
                    gradientColors: [Color(0xFF009245), Color(0xFFFCEE21)],
                    onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs()));
                }),
              ],
            ),
            _buildCard(
              context,
              'Application',
              [
                _buildListTile(context,
                    icon: Icons.logout,
                    title: 'Log out',
                    gradientColors: [Color(0xFFD4145A), Color(0xFFFBB03B)],
                    onPressed: () {
                  Navigator.pushNamed(context, login);
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: FooterSection(route: userInformation),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required List<Color> gradientColors,
      VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Icon(icon),
        ),
        title: Text(title),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

}

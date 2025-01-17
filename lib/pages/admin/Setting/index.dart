import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF5F6FA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              Text('1.0.0'),
              Text(
                'Release date:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              Text('12/02/2025'),
              Text(
                'Release notes:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enhanced User Interface:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'We have revamped the user interface with new icons, a cleaner layout, and more eye-friendly colors. This will make it easier and more comfortable for you to track your health using the app.'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personalized Dashboard:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'We have introduced a personalized dashboard that adapts to your health goals and activities. This feature allows you to easily access the most relevant information and insights at a glance.'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personalized Notifications:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'You can now customize notifications according to your personal needs, including medication reminders, appointment schedules, and health status updates. These settings can be easily adjusted in the notification settings section.',
                    maxLines: 2, // Allows wrapping
                    overflow: TextOverflow
                        .ellipsis, // Adds ellipsis if the text exceeds the limit
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DisplayingResult extends StatelessWidget {
  final String result;

  DisplayingResult({required this.result});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        result,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

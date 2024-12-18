import 'package:flutter/material.dart';
import '../index.dart';

class DisplayingResult extends StatefulWidget {
  final String result;

  const DisplayingResult({Key? key, required this.result}) : super(key: key);

  @override
  State<DisplayingResult> createState() => _DisplayingResultState();
}

class _DisplayingResultState extends State<DisplayingResult> {
  @override
  Widget build(BuildContext context) {

    final int prediction = int.tryParse(widget.result) ?? -1;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 139, 251),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCard(),
          
        ],
      ),
    );
  }

  Widget _buildCard() {
    return const Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.white,
      child: SizedBox(
        width: 300,
        height: 200,
      ),
    );
  }
}

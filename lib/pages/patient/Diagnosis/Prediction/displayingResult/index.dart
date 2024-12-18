import 'package:flutter/material.dart';

class DisplayingResult extends StatefulWidget {
  final String result;

  const DisplayingResult({super.key, required this.result});

  @override
  State<DisplayingResult> createState() => _DisplayingResultState();
}

class _DisplayingResultState extends State<DisplayingResult> {
  @override
  Widget build(BuildContext context) {
    final int prediction = int.tryParse(widget.result) ?? -1;
    Color? backgroundColor = (prediction == 1) ? Colors.green : Colors.red;
    String title = (prediction == 1) ? 'Congratulation!' : 'Warning!';
    String result =
      (prediction == 1) ?
      'Your heart is in good shape' :
      'There is high risk of heart attack';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: _buildCard(result),
          )
        ],
      )
    );
  }

  Widget _buildCard(result) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: _buildCardContent(result),
      ),
    );
  }

  Widget _buildCardContent(result) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          result,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
        ),
        Divider(
          height: MediaQuery.of(context).size.height * 0.1,
          thickness: 1,
          indent: MediaQuery.of(context).size.width * 0.1,
          endIndent: MediaQuery.of(context).size.width * 0.1,
        )
      ],
    );
  }
}


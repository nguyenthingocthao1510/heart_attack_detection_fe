import 'package:flutter/material.dart';

class RadioInput<T> extends StatefulWidget {
  static var value;
  static var groupValue;

  const RadioInput({
    super.key,
    required String value,
    required String groupValue,
  });

  @override
  _RadioInputState createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: RadioInput.value,
      groupValue: RadioInput.groupValue,
      activeColor: const Color.fromARGB(255, 20, 139, 251),
      onChanged: (value) {
        setState(() {value = value!;});
      },
    );
  }
}



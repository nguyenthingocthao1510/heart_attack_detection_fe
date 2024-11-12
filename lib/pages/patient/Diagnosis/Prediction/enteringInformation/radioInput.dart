import 'package:flutter/material.dart';

class RadioInput<T> extends StatefulWidget {
  static dynamic value;
  static dynamic groupValue;

  const RadioInput({
    super.key,
    required dynamic value,
    required dynamic groupValue,
  });

  @override
  _RadioInputState createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: RadioInput.value,
          groupValue: RadioInput.groupValue,
          activeColor: const Color.fromARGB(255, 20, 139, 251),
          onChanged: (value) {
            setState(() {value = value!;});
          },
        ),
        Text(RadioInput.value)
      ] 
    );
  }
}



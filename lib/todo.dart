import 'package:flutter/material.dart';

// stateful
class Todo extends StatelessWidget {
  const Todo({super.key, required this.task});

  final String task;
  final bool isSwitchedOn = false;

  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;

    return Row(
      children: [
        Checkbox(value: isChecked, onChanged:(bool value) {
                    setState(() {
                      firstCheck = !value;
                      secondCheck = value;
                    });),
        Text(task),
      ],
    );
  }
}

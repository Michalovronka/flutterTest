import 'package:flutter/material.dart';
import 'package:todoapp/task.dart';

// stateful
class Todo extends StatefulWidget {
  const Todo({super.key, required this.task});

  final Task task;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        Text(widget.task.name),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todoapp/sharedstate.dart';
import 'package:todoapp/todo.dart';

void main() {
  List<String> tasks = [];
  for (var i = 0; i < 1000; i++) {
    tasks.add("a");
  }
  runApp(
    SharedState(tasks: tasks, color: Colors.red, child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    List<String> tasks = SharedState.of(context).tasks;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: const Text('Homeee lol'),
        ),
        body: ListView.builder(
          key: const Key('long_list'),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Todo(task: tasks[index]);
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

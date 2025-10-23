import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/sharedstate.dart';
import 'package:todoapp/task.dart';
import 'package:todoapp/todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Task> tasks = [];
  try {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/todos'),
    );
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      for (var i = 1; i < json.length+1; i++) {
        var value = json['$i'];
        print(value);

        tasks.add(
          Task(
            name: value['title'],
            isCompleted: value['isCompleted'],
          ),
        );
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('HTTP request failed: $e');
  }

  /*final prefs = await SharedPreferences.getInstance();
  for (var i = 0; i < (prefs.getInt('numberOfTasks') ?? 0); i++) {
    tasks.add(Task(name: i.toString(), isCompleted: false));
  }*/
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
  int numberOfTasks = 0;
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = SharedState.of(context).tasks;

    Future<void> addNumberOfTasks() async {
      List<Task> tasks = [];
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setInt('numberOfTasks', numberOfTasks);
      });
      SharedState.of(
        context,
      ).tasks.removeRange(0, SharedState.of(context).tasks.length);
      for (var i = 0; i < (prefs.getInt('numberOfTasks') ?? 0); i++) {
        tasks.add(Task(name: i.toString(), isCompleted: false));
      }
      SharedState.of(context).tasks.addAll(tasks);
    }

    int? parsed;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: const Text('Homeee lol'),
        ),
        body: Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) => {
                  parsed = int.tryParse(value),
                  if (parsed != null)
                    {
                      setState(() {
                        numberOfTasks = parsed!;
                      }),
                    },
                },
                maxLength: 20,
              ),
            ),
            TextButton(
              onPressed: addNumberOfTasks,
              child: (Text("Save")),
            ),
            Expanded(
              child: ListView.builder(
                key: const Key('long_list'),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Todo(task: tasks[index]);
                },
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
      Uri.parse('http://10.0.2.2:8000/todos'),
    );
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      for (var i = 1; i < json.length + 1; i++) {
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
  late TextEditingController _controller;
  int numberOfTasks = 0;

  bool isEmpty = true;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // ✅ initialize here
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ clean up when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = SharedState.of(context).tasks;

    void handlePost() async {
      var a = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/todos?title=${_controller.text}',
        ),
      );
      Map<String, dynamic> b = jsonDecode(a.body);
      List<Task> result = b.keys.map<Task>((key) {
        return Task(
          name: b[key]['title'],
          isCompleted: b[key]['isCompleted'],
        );
      }).toList();

      _controller.text = "";
      setState(() {
        SharedState.of(context).tasks
          ..clear()
          ..addAll(result);
      });
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                    onChanged: (value) => {
                      setState(() {
                        isEmpty = value.isEmpty;
                      }),
                    },
                  ),
                ),
                IconButton(
                  onPressed: handlePost,
                  icon: Icon(
                    Icons.send,
                    color: isEmpty ? Colors.grey : Colors.black54,
                  ),
                ),
              ],
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

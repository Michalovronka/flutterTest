import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/sharedstate.dart';
import 'package:todoapp/task.dart';
import 'package:todoapp/todo.dart';

Future<void> main() async {
  List<Task> tasks = [];

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

    Future<void> loadTasks() async {
      List<Task> tasks = [];
      final prefs = await SharedPreferences.getInstance();
      for (var i = 0; i < (prefs.getInt('numberOfTasks') ?? 0); i++) {
        tasks.add(Task(name: i.toString(), isCompleted: false));
        print(tasks[i]);
      }

      SharedState.of(context).tasks.addAll(tasks);
    }

    Future<void> addNumberOfTasks() async {
      final prefs = await SharedPreferences.getInstance();
      print("adduju");
      print(numberOfTasks);
      setState(() {
        prefs.setInt('numberOfTasks', numberOfTasks);
      });
      loadTasks();
    }

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
                  setState(() {
                    numberOfTasks = int.parse(value);
                  }),
                  print("Numbetr of taks: "),
                  print(numberOfTasks),
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

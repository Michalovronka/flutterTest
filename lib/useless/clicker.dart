
/*import 'package:flutter/material.dart';
import 'package:todoapp/sharedstate.dart';

void main() {
  runApp(SharedState(color: Colors.red, child: MyApp()),);
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: const Text('Home lol'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(100),
                padding: const EdgeInsets.all(20),
                color: Colors.amber,
                child: const Text(
                  "body",
                  style: TextStyle(
                    letterSpacing: 10,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              Text("blal"),
              Text("$count"),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.cabin),
                onPressed: () {
                  setState(() {
                    count--;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
*/
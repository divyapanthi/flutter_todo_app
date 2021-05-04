import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  int counter = 0;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Todo Woo"),
        ),
        body: Center(
            child: Text(
                "Your todos will appear here."
            )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              counter++;
              print("Todo $counter");
            });
          },
          label: const Text("Create Todo"),
          icon: const Icon(Icons.add_circle),
        ),
      ),
    );
  }
}
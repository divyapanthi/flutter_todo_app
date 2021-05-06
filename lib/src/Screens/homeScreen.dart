import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/createTodoScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  int counter = 0;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
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
          onPressed: () async{
            var data = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateTodoScreen();
                    }
                )
            );
            print("Data from second screen $data");
          },
          label: const Text("Create Todo"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
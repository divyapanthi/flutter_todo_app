import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todoModel.dart';
import 'package:todo_app/src/screens/createTodo.dart';
import 'package:todo_app/src/widgets/todoListWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  final List<Todo> todolist=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todo Woo"),
      ),
      body: todolist.isEmpty ? Center(child: Text("Your todos will appear here")) : TodoListWidget(todolist, updateTodo, removeTodo),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushCreateTodoScreen();
        },
        // label: const Text("Create Todo"),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> pushCreateTodoScreen() async {
    var data = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
    {
      return CreateTodo();
    }
    ));
    setState(() {
      todolist.add(data);
    });
  }

  void updateTodo(Todo todo, String title){
    int index = todolist.indexWhere((singleTodo) => singleTodo.title==title);
    setState(() {
      todolist[index] = todo;
    });
  }

  void removeTodo(String title){
    setState(() {
      todolist.removeWhere((selectedTodo) => selectedTodo.title == title);
    });
  }

}

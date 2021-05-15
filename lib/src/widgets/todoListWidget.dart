import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todoModel.dart';
import 'package:todo_app/src/screens/updateTodo.dart';



class TodoListWidget extends StatefulWidget {


 final List<Todo> todolist;
 final Function(Todo todo, String title) updateTodo;
 final Function(String title) removeTodo;
  TodoListWidget(this.todolist, this.updateTodo, this.removeTodo);

  @override
  TodoListWidgetState createState() => TodoListWidgetState();
}

class TodoListWidgetState extends State<TodoListWidget> {

  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return buildTodoItem(widget.todolist[index]);
      },
      itemCount: widget.todolist.length,
    );
  }

  Widget buildTodoItem(Todo todo) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if(todo.date!.isBefore(today)){
        isCompleted = true;
    }
    else{
        isCompleted = false;
    }
    return Card(
      margin: EdgeInsets.all(12),
      child: InkWell(
        splashColor: Colors.amber,
        highlightColor: Colors.cyan,
        onTap: (){
          pushUpdateTodoScreen(Todo(todo.title!, todo.description, todo.date));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isCompleted ? buildCheckIcon() : Text(""),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(todo.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),
                  ),
                  SizedBox(height: 8,),
                  Text(todo.description!,
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
                  SizedBox(height: 8,),
                  Text(todo.date.toString().split(' ')[0],
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple.withOpacity(0.8),)),
                ],
              ),
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 36,
                color: Colors.blueGrey,
                splashColor: Colors.amber,
                onPressed: () {
                  showAlertDialog(todo);
                },
              ),
            ],
          ),
        ),
      ),
    );

  }

  IconButton buildCheckIcon() {
    return IconButton(
      icon: Icon(Icons.check_circle),
      iconSize: 32,
      color: Colors.green,
      onPressed: (){}
      );
  }

  void showAlertDialog(Todo todo) {
      //set up the buttons
     Widget cancelButton = TextButton(
       child:  const Text('Cancel'),
       onPressed: (){
         Navigator.of(context).pop();
       },
     );

     Widget deleteButton = TextButton(
         child: const Text('Delete'),
         onPressed: () {
           deleteTodo(todo.title);
           Navigator.of(context).pop();
         },
     );

     //set up the Alert Dialog
     AlertDialog alert = AlertDialog(
       title: Text("Delete task ${todo.title} ?"),
       content: Text("This task will be removed from your todo list."),
       actions: [
         cancelButton,
         deleteButton
       ],
     );

     showDialog(
         context: context,
         builder: (BuildContext context){
           return alert;
         }
     );
  }

  void deleteTodo(String? title){
    widget.removeTodo(title!);
  }

  void pushUpdateTodoScreen(Todo todo) async{
    var data = await Navigator.push(context,MaterialPageRoute(builder: (context) => UpdateTodo(todo)));
    widget.updateTodo(data, todo.title!);
  }
}



import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todoModel.dart';

class TodoListWidget extends StatefulWidget {

 final List<Todo> todolist;
  TodoListWidget(this.todolist);

  @override
  TodoListWidgetState createState() => TodoListWidgetState();
}

class TodoListWidgetState extends State<TodoListWidget> {

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
    return Card(
      margin: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),
                ),
                SizedBox(height: 8,),
                Text(todo.description!,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
                SizedBox(height: 6,),
                Text(todo.date.toString().split(' ')[0],
                  style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.4),)),
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
           removeTodo(todo.title);
           Navigator.of(context).pop();
         },
     );

     //set up the Alert Dialog
     AlertDialog alert = AlertDialog(
       title: Text("Delete ${todo.title} ?"),
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

  void removeTodo(String? title){
    setState(() {
      widget.todolist.removeWhere((selectedTodo) => selectedTodo.title == title);
    });
  }



  

}



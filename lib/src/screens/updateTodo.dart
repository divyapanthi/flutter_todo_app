import 'package:flutter/material.dart';
import 'package:todo_app/src/mixin/validation_mixin.dart';
import 'package:todo_app/src/models/todoModel.dart';

class UpdateTodo extends StatefulWidget {

  final Todo todo;
  UpdateTodo(this.todo);

  @override
  UpdateTodoState createState() => UpdateTodoState();
}

class UpdateTodoState extends State<UpdateTodo>  {

  final formkey = GlobalKey<FormState>();

  TextEditingController controllerText = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  List<Todo> todolist = [];
  String? todoTitle;
  String? todoDescription;

  bool ispicked = false;
  bool createTodoScreen = true;

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2030)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerText.text = widget.todo.title!;
    controllerDescription.text = widget.todo.description!;
    selectedDate = widget.todo.date!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Todo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          child: Form(
            child: Column(
              children: [
                // mainAxisSize: MainAxisSize.max,
                buildAddTaskField(context),
                SizedBox(height: 16,),
                buildDescriptionField(context),
                SizedBox(height: 16,),
                buildDatePickerField(context),
                SizedBox(height: 16.0,),
                buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(Todo(controllerText.text, controllerDescription.text, selectedDate));
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          // primary: Color(0xff625834),
        ),
        child: Text(
          "Update",
        ),
      ),
    );
  }

  Widget buildDatePickerField(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            selectDate(context);
            setState(() => ispicked = true);
          },
          style: ElevatedButton.styleFrom(
            // primary: Color(0xff625834),
            padding: EdgeInsets.all(16),
          ),
          child: Text("${selectedDate.toLocal()}".split(' ')[0]))
    );
  }

  Widget buildAddTaskField(BuildContext context) {
    final node = FocusScope.of(context);
    return TextFormField(
      controller: controllerText,
      onSaved: (String? val) {
        todoTitle = val;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Add Title',
          hintText: 'Your todo title here..'),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
    );
  }

  Widget buildDescriptionField(BuildContext context) {
    return TextFormField(
      controller: controllerDescription,
      onChanged: (String? val) {
        todoDescription = val;
      },
      minLines: 2,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Add Description',
          hintText: 'More information on your todo..'),
    );
  }

}
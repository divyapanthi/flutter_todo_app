import 'package:flutter/material.dart';
import 'package:todo_app/src/mixin/validation_mixin.dart';
import 'package:todo_app/src/models/todoModel.dart';

class CreateTodo extends StatefulWidget {
  @override
  CreateTodoState createState() => CreateTodoState();
}

class CreateTodoState extends State<CreateTodo> with ValidationMixin {

  final formkey = GlobalKey<FormState>();
  String? todoTitle;
  String? todoDescription;

  bool ispicked = false;

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime?  picked = (await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015,8),
        lastDate: DateTime(2030)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          child: Form(
            key: formkey,
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



  Widget buildAddTaskField(BuildContext context) {
    final node = FocusScope.of(context);
    return TextFormField(
      onSaved: (String? val) {
        todoTitle = val;
      },
      validator: validateTask,
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
      onSaved: (String? val) {
        todoDescription = val;
      },
      validator: validateDescription,
      minLines: 2,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Add Description',
          hintText: 'More information on your todo..'),
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
          child: ispicked ? Text("${selectedDate.toLocal()}".split(' ')[0]) : Text("Pick completion date")),
    );
  }


  SizedBox buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          bool isValid = formkey.currentState!.validate();
          if(isValid){
            formkey.currentState!.save();
          }
          onSaveButtonClick();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          // primary: Color(0xff625834),
        ),
        child: Text(
          "Save",
        ),
      ),
    );
  }


  void onSaveButtonClick() {
    Navigator.of(context).pop(Todo(todoTitle!, todoDescription!, selectedDate));
  }

}































import 'package:flutter/material.dart';

class CreateTodoScreen extends StatefulWidget {
  @override
  CreateTodoScreenState createState() => CreateTodoScreenState();
}

class CreateTodoScreenState extends State<CreateTodoScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
   final node = FocusScope.of(context);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Create Todos"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Title',
                  ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                ),

                SizedBox(height: 16,),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:  "${selectedDate.toLocal()}".split(' ')[0],
                  ),
                  onTap: () => selectDate(context),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => selectDate(context),
                    child:  Text("Pick Date"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop(["success","fail"]);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                    ),
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

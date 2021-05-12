import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/homeScreen.dart';

void main() {
  runApp((App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color(0xffda7422),
        // accentColor: Color(0xff30362f),
        primarySwatch: Colors.amber,
      ),
      home: HomeScreen(),
    );
  }
}

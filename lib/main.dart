import 'package:flutter/material.dart';
import 'package:todo_app/src/Screens/homeScreen.dart';

void main() {
  runApp((App()));
}



class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

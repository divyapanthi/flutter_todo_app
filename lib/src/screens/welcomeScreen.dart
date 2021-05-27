import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
            child: Image(
                image: AssetImage("images/bg7.jpg"),

            ),
          ),
      ),
    );
  }
}

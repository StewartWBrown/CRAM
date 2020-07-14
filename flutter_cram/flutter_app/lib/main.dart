import 'package:flutter/material.dart';
import 'mainScreen.dart';
import 'model/subject.dart';

void main() {
  runApp(
    CramApp()
  );
}

class CramApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'CRAM App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainScreen(),
    );


  }
}

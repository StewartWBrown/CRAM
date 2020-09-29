import 'package:flutter/material.dart';
import 'mainScreen.dart';
void main(){

  runApp(
      CramApp()
  );
}

class CramApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'CRAM APP',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainScreen(0),
    );


  }
}

import 'package:flutter/material.dart';
import 'addSubject.dart';
import '../model/subject.dart';
import 'expandSubjectCard.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import '../main/main.dart';

class DeleteSubject extends StatelessWidget{
  final Subject subject;

  DeleteSubject(this.subject);


  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("Confirm deletion"),
      content: Text("Are you sure you you want to delete subject " + subject.name + "? \n \n \n(Not from your existance i'm afraid, just from this app. The subject wont just vanish irl. Sorry.)"),
      actions: <Widget>[
        // Line to redirect to subject half full idk if that works
        FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ),
        FlatButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: (){
            DatabaseHelper.instance.deleteSubject(subject.name);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CramApp()));
          },
        )

      ],
      elevation: 24.0,
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

  }

}


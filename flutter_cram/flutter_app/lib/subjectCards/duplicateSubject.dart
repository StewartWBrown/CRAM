import 'package:flutter/material.dart';
import '../model/subject.dart';


class DuplicateSubject extends StatelessWidget{
  final Subject subject;

  DuplicateSubject(this.subject);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("Error"),
      content: Text("The subject: '" + subject.name + "' Already exists"),
      actions: <Widget>[

        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: (){
            Navigator.pop(context);
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


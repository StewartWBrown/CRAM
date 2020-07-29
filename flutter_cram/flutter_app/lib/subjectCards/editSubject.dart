import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';

import 'expandSubjectCard.dart';

class EditSubject extends StatelessWidget {
  final Subject subject;

  EditSubject(this.subject);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(subject.name),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Number of workloads: " + subject.workloads.toString()),
          Text("\nSubject Difficulty: " + subject.difficulty.toString()),
          Text("\n \nDate to begin studying: " + subject.startDate),
          Text("\nDate to finish studying: " + subject.endDate),
          Text("\nExam Date: " + subject.examDate),
        ],
      ),

      actions: <Widget>[
        // Line to redirect to subject half full idk if that works
        // MaterialPageRoute(builder: (context) => AddSubject(subject)
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
            "Save Changes",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: (){
          },
        )
      ],
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

  }


}

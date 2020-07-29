import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'deleteSubject.dart';
import 'addSubject.dart';
import '../model/subject.dart';

class ExpandSubjectCard extends StatelessWidget{
  final Subject subject;

  ExpandSubjectCard(this.subject);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(subject.name),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,

                                                                               
        ),

      actions: <Widget>[
        // Line to redirect to subject half full idk if that works
        // MaterialPageRoute(builder: (context) => AddSubject(subject)
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            print("BUTTON PRESSED");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeleteSubject(subject)),
            );
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

/*
content: Text("Start Date: " + subject.startDate + '\n' +
            "End Date: " + subject.endDate + '\n' +
            "Exam Date: " + subject.examDate
        ),
        actions: <Widget>[
          // Line to redirect to subject half full idk if that works
          // MaterialPageRoute(builder: (context) => AddSubject(subject)
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              print("BUTTON PRESSED");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeleteSubject(subject)),
              );
            },
          )
        ],
 */


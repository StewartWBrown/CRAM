import 'package:flutter/material.dart';
import 'addSubject.dart';
import 'model/subject.dart';

class ExpandSubjectCard extends StatelessWidget{
  final Subject subject;

  ExpandSubjectCard(this.subject);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(subject.name),
        content: Text("Start Date: " + subject.startDate.day.toString() + '/' +
            subject.startDate.month.toString() + '/' +
            subject.startDate.year.toString() + '\n' +
            "End Date: " + subject.endDate.day.toString() + '/' +
            subject.endDate.month.toString() + '/' +
            subject.endDate.year.toString() + '\n' +
            "Exam Date: " + subject.examDate.day.toString() + '/' +
            subject.examDate.month.toString() + '/' +
            subject.examDate.year.toString()
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print("BUTTON PRESSED");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddSubject(subject)),
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


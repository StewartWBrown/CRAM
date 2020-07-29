import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/subjectCards/editSubject.dart';
import 'package:intl/intl.dart';
import 'deleteSubject.dart';
import 'addSubject.dart';
import '../model/subject.dart';

class ExpandSubjectCard extends StatelessWidget{
  final Subject subject;

  ExpandSubjectCard(this.subject);

  @override
  Widget build(BuildContext context) {
    var formattedStartDate = DateTime.parse(subject.startDate);
    var formattedEndDate = DateTime.parse(subject.endDate);
    var formattedExamDate = DateTime.parse(subject.examDate);

    return AlertDialog(
        title: Text(subject.name),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Number of workloads: " + subject.workloads.toString()),
            Text("\nSubject Difficulty: " + subject.difficulty.toString()),
            Text("\n \nDate to begin studying: " + new DateFormat.yMMMd().format(formattedStartDate)),
            Text("\nDate to finish studying: " + new DateFormat.yMMMd().format(formattedEndDate)),
            Text("\nExam Date: " + new DateFormat.yMMMd().format(formattedExamDate)),
          ],
        ),

      actions: <Widget>[
        // Line to redirect to subject half full idk if that works
        // MaterialPageRoute(builder: (context) => AddSubject(subject)
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            var editInstance = EditSubject(subject);

            showDialog(context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return editInstance;
              },
            );
          },

        ),

        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            var deleteInstance = DeleteSubject(subject);

            showDialog(context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return deleteInstance;
              },
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


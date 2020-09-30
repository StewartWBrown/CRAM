import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/subjectCards/editSubject.dart';
import 'package:flutter_app/subjectCards/subjectInfo.dart';
import 'package:flutter_app/subjectCards/subjectWorkloads.dart';
import 'deleteSubject.dart';
import '../model/subject.dart';

class ExpandSubjectCard extends StatelessWidget{
  final Subject subject;
  Color diffColor;

  ExpandSubjectCard(this.subject);

  @override
  Widget build(BuildContext context) {
    var formattedStartDate = DateTime.parse(subject.startDate);
    var formattedEndDate = DateTime.parse(subject.endDate);
    var formattedExamDate = DateTime.parse(subject.examDate);

    switch(subject.difficulty){
      case 1: {
        diffColor = Colors.green;
      }
      break;

      case 2: {
        diffColor = Colors.orange;
      }
      break;

      case 3:{
        diffColor = Colors.red;
      }
      break;

      default:{
        diffColor = Colors.white;
      }
    }

    return AlertDialog(

        content:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //name and difficulty at top
              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    subject.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),

              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child:
                  RawMaterialButton(
                    fillColor: diffColor,
                    child:
                    Text(
                      subject.difficulty.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    padding: EdgeInsets.all(0.0),
                    shape: CircleBorder(),
                    onPressed: () {},
                  ),
                ),
              ),

              SizedBox(height: 30),

              //exam info button
              RawMaterialButton(
                onPressed: () {
                  var subjectInfo = SubjectInfo(subject, diffColor);
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return subjectInfo;
                    },
                  );
                },
                elevation: 40.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.calendar_today,
                  size: 80.0,
                ),
                padding: EdgeInsets.all(25.0),
                shape: CircleBorder(),
              ),
              Text(
                "Exam Info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              //workloads button
              RawMaterialButton(
                onPressed: () {
                  var showWorkloads = SubjectWorkloads(subject, diffColor);
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return showWorkloads;
                    },
                  );
                },
                elevation: 40.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.library_books,
                  size: 80.0,
                ),
                padding: EdgeInsets.all(25.0),
                shape: CircleBorder(),
              ),
              Text(
                "Workloads",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
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


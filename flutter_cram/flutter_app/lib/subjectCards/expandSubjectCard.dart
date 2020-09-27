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

        content:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //name and difficulty at top
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      subject.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child:
                      RawMaterialButton(
                        fillColor: Colors.white,
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
                      ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              //exam info button
              RawMaterialButton(
                onPressed: () {},
                elevation: 40.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.calendar_today,
                  size: 80.0,
                ),
                padding: EdgeInsets.all(25.0),
                shape: CircleBorder(),
              ),
              Text("Exam Info"),

              SizedBox(height: 30),

              //workloads button
              RawMaterialButton(
                onPressed: () {},
                elevation: 40.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.library_books,
                  size: 80.0,
                ),
                padding: EdgeInsets.all(25.0),
                shape: CircleBorder(),
              ),
              Text("Workloads"),
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


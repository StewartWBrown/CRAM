import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';

class SubjectWorkloads extends StatelessWidget{
  Color diffColor;
  Subject subject;
  Future<List> _workloads;

  SubjectWorkloads(this.subject, this.diffColor);


  @override
  Widget build(BuildContext context) {
    _workloads = updateWorkloadListForSubject(subject.name);

    return AlertDialog(
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //subject name
          Text(
            subject.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),

          //difficulty circle
          Align(
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

          FutureBuilder(
            future: _workloads,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator()
                );
                default:
                List<Workload> _workloads = snapshot.data ?? [];
                print(_workloads);

                return Container(

                );
              }
            }
          ),
        ]
      ),
    );
  }
}

Future<List<Workload>> updateWorkloadListForSubject(String subjectName)async{
  var tempList = DatabaseHelper.instance.returnWorkloadsForSubject(subjectName);
  return tempList;
}
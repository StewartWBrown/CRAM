import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';

import 'mainScreen.dart';

List<Subject> localSubjects;
List<Workload> localWorkloads;
List localSkipDays;
int wlID;

class FutureArea extends StatelessWidget{

  final Future<List<Subject>> subjects = updateSubjectList();
  final Future<List<Workload>> workloads = updateWorkloadList();
  final Future<List> skipDays = DatabaseHelper.instance.queryAllSkipDays();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
          () =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => MainScreen()))
    );

    return FutureBuilder(
        future: Future.wait([subjects, workloads, skipDays]),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator()
              );
            default:
              List<Subject> subjects = snapshot.data[0] ?? [];
              List<Workload> workloads = snapshot.data[1] ?? [];
              List skipDays = snapshot.data[2] ?? [];

              subjects.isNotEmpty ? localSubjects = subjects : localSubjects = [];
              workloads.isNotEmpty ? localWorkloads = workloads : localWorkloads = [];
              localSkipDays = skipDays;

              workloads.isNotEmpty ? wlID = workloads.last.workloadID + 1 : wlID = 0;

              return Column(
                children: <Widget>[
                  Text(
                    "APP LOADINGGGGGGG",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),

                  ),
                ],
              );
          }
        }
    );
  }

}
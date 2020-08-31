import 'package:flutter/material.dart';
import '../subjectCards/addSubject.dart';
import 'spread.dart';
import '../subjectCards/homePageBody.dart';
import '../model/subject.dart';
import '../model/workload.dart';
import '../calendarDisplay/calendar.dart';

//var calendar1 = new Map<DateTime, Map<String, List<Workload>>>();

class MainScreen extends StatelessWidget {
  Future<List<Subject>> subjects = updateSubjectList();
  Future<List<Workload>> workloads = updateWorkloadList();

  //temporary subjects list to prove spread works
  static List<Subject> test_subjects = [
    Subject(
        name: "Algorithms",
        workloads: 10,
        difficulty: 1,
        startDate: DateTime(2020, 7, 10).toString(),
        endDate: DateTime(2020, 8, 7).toString(),
        examDate: DateTime(2020, 8, 8).toString()),
    Subject(
        name: "OOSE",
        workloads: 12,
        difficulty: 2,
        startDate: DateTime(2020, 7, 14).toString(),
        endDate: DateTime(2020, 8, 20).toString(),
        examDate: DateTime(2020, 8, 21).toString()),
    Subject(
        name: "Mobile HCI",
        workloads: 15,
        difficulty: 1,
        startDate: DateTime(2020, 7, 10).toString(),
        endDate: DateTime(2020, 7, 26).toString(),
        examDate: DateTime(2020, 7, 28).toString()),
    Subject(
        name: "Data Fundamentals",
        workloads: 10,
        difficulty: 3,
        startDate: DateTime(2020, 7, 10).toString(),
        endDate: DateTime(2020, 8, 13).toString(),
        examDate: DateTime(2020, 8, 14).toString()),
  ];

  //temporary workloads list to prove spread works
  static List<Workload> test_workloads = updateTestWorkloadList();

  //call spread
  Map<DateTime, Map<String, List<Workload>>> calendar1 = Spread().spread(test_subjects, test_workloads, List());

  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: new Text("CRAM APP"),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: <Tab>[
                      new Tab(text: "SUBJECTS"),
                      new Tab(text: "CALENDAR"),
                    ],
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                new HomePageBody(),
                new Calendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_app/addSubject.dart';
import 'package:flutter_app/spread.dart';
import 'home_page_body.dart';
import 'model/subject.dart';
import 'model/workload.dart';
import 'spread.dart';
import 'calendar.dart';

var calendar1 = new Map<DateTime, Map<String, List<Workload>>>();

class MainScreen extends StatelessWidget {
  Future<List<Subject>> subjects = updateList();

  @override
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
                // NO CALENDAR
                new HomePageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
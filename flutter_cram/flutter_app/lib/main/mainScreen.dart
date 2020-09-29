import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard/dashboardBody.dart';
import '../subjectCards/subjectBody.dart';
import '../calendarDisplay/calendar.dart';

DateTime mostRecentlyVisitedDay = DateTime.now();

class MainScreen extends StatelessWidget {

  String pageTitle;
  int selectedPage;
  MainScreen(this.selectedPage);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: selectedPage,
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: new Text("Workloads"),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: <Tab>[
                      new Tab(icon: Icon(Icons.view_list)),
                      new Tab(icon: Icon(Icons.home)),
                      new Tab(icon: Icon(Icons.calendar_today)),
                    ],
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                new SubjectBody(),
                new DashboardBody(),
                new Calendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_app/spread.dart';
import 'home_page_body.dart';
import 'addSubject.dart';
import 'model/subject.dart';
import 'spread.dart';

class MainScreen extends StatelessWidget {
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
                  new HomePageBody(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Spread().spread(subjects, List());
              },
              label: Text('Add Subject'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
          ),
        ),
    );
  }
}


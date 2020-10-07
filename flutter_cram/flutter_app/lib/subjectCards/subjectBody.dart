import 'package:flutter/material.dart';
import 'package:flutter_app/main/futureArea.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/main/spread.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'addSubject.dart';
import 'subjectRow.dart';

class SubjectBody extends StatefulWidget {
  @override
  _SubjectBodyState createState() => _SubjectBodyState();
}

class _SubjectBodyState extends State<SubjectBody>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (localSubjects.isEmpty) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddSubject()),
            );
          },
          label: Text('Add Subject'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      );
    }
    else {
      return Scaffold(
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22),
            backgroundColor: Color(0xFF801E48),
            visible: true,
            curve: Curves.bounceIn,
            children: [
              // FAB 1
              SpeedDialChild(
                  child: Icon(Icons.add),
                  backgroundColor: Color(0xFF801E48),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSubject()),
                    );
                  },
                  label: 'Add Subject',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16.0),
                  labelBackgroundColor: Color(0xFF801E48)),
              // FAB 2
              SpeedDialChild(
                  child: Icon(Icons.pregnant_woman),
                  backgroundColor: Color(0xFF801E48),
                  onTap: () {
                    Spread().spread(localSubjects, localWorkloads, List());
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
                  },
                  label: 'Spread Workloads',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16.0),
                  labelBackgroundColor: Color(0xFF801E48))
            ],
          ),
          body: Row(
              children: [
                Expanded(
                  child: new Container(
                    color: new Color(0xFF0c6f96),
                    child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0),
                          sliver: new SliverList(
                            delegate: new SliverChildBuilderDelegate(
                                  (context, index) =>
                              new SubjectRow(localSubjects[index]),
                              childCount: localSubjects.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])

      );

    }
  }
}

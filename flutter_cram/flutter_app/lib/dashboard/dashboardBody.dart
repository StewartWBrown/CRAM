import 'package:flutter/material.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';
import 'package:flutter_app/subjectCards/workloadRow.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

class DashboardBody extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardBody> with AutomaticKeepAliveClientMixin<DashboardBody>{

  String currentDate = new DateFormat.d().format(new DateTime.now()).toString();
  String currentMonth = new DateFormat.MMMM().format(new DateTime.now()).toString();
  Future<List<Subject>> subjects;
  Future<List<Workload>> workloads;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    subjects = updateSubjectList();
    workloads = updateWorkloadList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: Future.wait([subjects, workloads]),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator()
              );
            default:
              currentPage = 1;

              List<Subject> subjects = snapshot.data[0] ?? [];
              List<Workload> workloads = snapshot.data[1] ?? [];

              if (subjects.isEmpty) {
                return Scaffold(
                  // Action Button at bottom
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
                          onTap: () {},
                          label: 'Add Subject',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16.0),
                          labelBackgroundColor: Color(0xFF801E48)
                      ),
                    ],
                  ),
                );
              }
              else {
                return Scaffold(
                    body:
                    Column(
                        children: [
                        Container(
                          padding: EdgeInsets.all(50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[
                             Column(
                              children:[
                                Text(currentDate,
                                style: TextStyle(fontSize: 90)),
                                Text(currentMonth, style: TextStyle(fontSize: 30)),
                               ],
                              ),
                            ],
                          ),
                        ),

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
                                        new WorkloadRow(workloads[index]),
                                        childCount: workloads.length,
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
    );

  }
}
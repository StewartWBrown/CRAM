import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../subjectCards/addSubject.dart';
import '../main/mainScreen.dart';
import '../model/subject.dart';
import '../model/workload.dart';
import 'expandWorkload.dart';


class Calendar extends StatefulWidget{

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, Map<String, List<Workload>>> _calendar;
  Map<DateTime, List<Workload>> _events;
  List<Workload> _selectedEvents;
  Future<List<Workload>> _workloads;
  ExpandWorkload _expandWorkload;

  @override
  void initState() {
    super.initState();
    _workloads = updateWorkloadList();
    _controller = CalendarController();
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => AddSubject()),
//            );
        },
        label: Text('Manage study'),
        icon: Icon(Icons.edit_attributes),
        backgroundColor: Colors.orange,
      ),

      body: FutureBuilder(
        future: _workloads,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator()
              );
            default:
              List<Workload> workloads = snapshot.data ??  [];

              _calendar = downloadCalendar(workloads);
              _events = createEvents();

              return Scaffold(
                  body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TableCalendar (
                            initialSelectedDay: mostRecentlyVisitedDay,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            initialCalendarFormat: CalendarFormat.week,
                            events: _events,
                            calendarController: _controller,
                            calendarStyle: CalendarStyle(
                              todayColor: Colors.orange,
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                            ),
                            onDaySelected: (date, events){
                              mostRecentlyVisitedDay = date;
                              if(events.isNotEmpty) {
                                setState(() {
                                  _selectedEvents = events;
                                });
                              }
                              else{
                                setState(() {
                                  _selectedEvents = [];
                                });
                              }
                            },
                            builders: CalendarBuilders(
                            ),
                          ),
                          ... _selectedEvents.map((event) => ListTile(
                            leading: Icon(Icons.album),
                            title: Text(event.workloadName),
                            onTap: (){
                              _expandWorkload = ExpandWorkload(event);
                              showDialog(context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return _expandWorkload;
                                },
                              );
                            },
                          )),
                        ],
                      )
                  )
              );
          }
        }
        ),
    );


  }

  Map<DateTime, List<Workload>> createEvents(){
    Map<DateTime, List<Workload>> events = Map();
    for(DateTime date in _calendar.keys){
      for(String subj in _calendar[date].keys){
        for(Workload wl in _calendar[date][subj]){
          events.putIfAbsent(date, () => List());
          events[date].add(wl);
        }
      }
    }
    return events;
  }

}

Map<DateTime, Map<String, List<Workload>>> downloadCalendar(List<Workload> workloads){
  Map<DateTime, Map<String, List<Workload>>> calendar = Map();
  for(Workload wl in workloads){
    if (wl.workloadDate != "NONE"){
      DateTime date = DateTime.parse(wl.workloadDate);
      calendar.putIfAbsent(date, () => Map<String, List<Workload>>());
      calendar[date].putIfAbsent(wl.subject, () => List<Workload>());
      calendar[date][wl.subject].add(wl);
    }
  }
  return calendar;
}
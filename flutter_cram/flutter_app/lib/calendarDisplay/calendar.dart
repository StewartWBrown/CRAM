import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../subjectCards/addSubject.dart';
import '../main/mainScreen.dart';
import '../model/subject.dart';
import '../model/workload.dart';


class Calendar extends StatefulWidget{
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, Map<String, List<Workload>>> _calendar;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  Future<List<Workload>> _workloads;

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
              print(_calendar);
              _events = createEvents(_calendar);

              return Scaffold(
                  body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TableCalendar (
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
                              setState(() {
                                _selectedEvents = events;
                              });

                            },
                            builders: CalendarBuilders(
                            ),
                          ),
                          ... _selectedEvents.map((event) => ListTile(
                            title: Text(event),
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

  Map<DateTime, List<dynamic>> createEvents(Map<DateTime, Map<String, List<Workload>>> calendar){
    Map<DateTime, List<dynamic>> events = Map();
    for(DateTime date in _calendar.keys){
      for(String subj in _calendar[date].keys){
        for(Workload wl in _calendar[date][subj]){
          events.putIfAbsent(date, () => List());
          events[date].add(wl.workloadName);
        }
      }
    }
    return events;
  }

}

Map<DateTime, Map<String, List<Workload>>> downloadCalendar(List<Workload> workloads){
  print("HERE ARE THE WORKLOADS");
  Map<DateTime, Map<String, List<Workload>>> calendar = Map();
  for(Workload wl in workloads){
    print(wl.workloadDate);
    if (wl.workloadDate != null){
      DateTime date = DateTime.parse(wl.workloadDate);
      calendar.putIfAbsent(date, () => Map<String, List<Workload>>());
      calendar[date].putIfAbsent(wl.subject, () => List<Workload>());
      calendar[date][wl.subject].add(wl);
    }
  }
  return calendar;
}
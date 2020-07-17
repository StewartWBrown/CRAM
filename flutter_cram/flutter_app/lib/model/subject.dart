import 'package:flutter_app/model/workload.dart';

class Subject{
  String name;
  int workloads;
  List<int> workCompleted;
  List<Workload> remainingWork;
  int difficulty;
  DateTime startDate;
  DateTime endDate;
  DateTime examDate;

  Subject(String _name, int _workloads, List<int> _workCompleted, int _difficulty, DateTime _startDate, DateTime _endDate, DateTime _examDate){
    this.name = _name;
    this.workloads = _workloads;
    this.workCompleted = _workCompleted;
    this.remainingWork = findWorkload();
    this.difficulty = _difficulty;
    this.startDate = _startDate;
    this.endDate = _endDate;
    this.examDate = _examDate;
  }

  List<Workload> findWorkload() {
    List<Workload> workload = new List();

    for(int i=1; i<workloads+1; i++){
      if(!workCompleted.contains(i)){
        workload.add(Workload(i, difficulty));
      }
    }
    return workload;
  }
}


List<Subject> subjects = [
  Subject(
    "Algorithms",
    10,
    [1,2],
    1,
    DateTime(2020, 2, 10),
    DateTime(2020,3,7),
    DateTime(2020, 3, 8)
),

  Subject(
    "OOSE",
    12,
    [1],
    2,
    DateTime(2020, 2, 14),
    DateTime(2020, 3, 20),
    DateTime(2020,3,21)
  ),


    Subject(
      "Mobile HCI",
      15,
      [],
      1,
      DateTime(2020,2,10),
      DateTime(2020, 2, 26),
      DateTime(2020, 2, 28)
    ),

    Subject(
      "Data Fundamentals",
      10,
      [1,2],
      3,
      DateTime(2020, 10, 2),
      DateTime(2020,3,13),
      DateTime(2020, 3, 14),
    ),
];






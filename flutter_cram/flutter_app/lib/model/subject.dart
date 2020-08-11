import 'package:flutter_app/database/databaseHelper.dart';

class Subject {
  final String name;
  final int workloads;
  final int difficulty;
  final String startDate;
  final String endDate;
  final String examDate;

  Subject(
      {this.name, this.workloads, this.difficulty, this.startDate, this.endDate, this.examDate});

  Map<String, dynamic> toMap(){
    return{
      'SubjectName': name,
      'NumberOfWorkloads':workloads,
      'Difficulty' : difficulty,
      'startDate' : startDate,
      'endDate': endDate,
      'examDate': examDate,
    };
  }
}

Future<List<Subject>> updateSubjectList()async{
  var tempList = DatabaseHelper.instance.queryAllSubjects();
  return tempList;
}

/*
  List<Workload> findWorkload() {
    List<Workload> workload = new List();

    for(int i=1; i<workloads+1; i++){
      if(!workCompleted.contains(i)){
        workload.add(Workload(i, difficulty));
      }
    }
    return workload;
  }





List<Subject> subjects = [
  Subject(
    "Algorithms",
    10,
    [1,2],
    1,
    DateTime(2020, 7, 10),
    DateTime(2020,8,7),
    DateTime(2020, 8, 8)
),

  Subject(
    "OOSE",
    12,
    [1],
    2,
    DateTime(2020, 7, 14),
    DateTime(2020, 8, 20),
    DateTime(2020,8,21)
  ),


    Subject(
      "Mobile HCI",
      15,
      [],
      1,
      DateTime(2020,7,10),
      DateTime(2020, 7, 26),
      DateTime(2020, 7, 28)
    ),

    Subject(
      "Data Fundamentals",
      10,
      [1,2],
      3,
      DateTime(2020, 7, 10),
      DateTime(2020,8,13),
      DateTime(2020, 8, 14),
    ),
];

*/
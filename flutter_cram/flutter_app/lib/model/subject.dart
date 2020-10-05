import 'package:flutter_app/database/databaseHelper.dart';

class Subject {
  final String name;
  final int workloads;
  final int difficulty;
  final String startDate;
  final String endDate;
  final String examDate;
  final String colour;
  final String icon;
  final String extraInfo;

  Subject(
      {this.name, this.workloads, this.difficulty, this.startDate, this.endDate, this.examDate, this.colour, this.icon, this.extraInfo});

  Map<String, dynamic> toMap(){
    return{
      'SubjectName': name,
      'NumberOfWorkloads':workloads,
      'Difficulty' : difficulty,
      'startDate' : startDate,
      'endDate': endDate,
      'examDate': examDate,
      'colour': colour,
      'icon' : icon,
      'extraInfo': extraInfo,
    };
  }
}

Future<List<Subject>> updateSubjectList()async{
  var tempList = DatabaseHelper.instance.queryAllSubjects();
  return tempList;
}


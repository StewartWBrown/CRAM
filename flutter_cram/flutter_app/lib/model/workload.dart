import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/main/futureArea.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/model/subject.dart';

class Workload {
  int workloadID;
  String subject;
  String workloadName;
  int workloadNumber;
  String workloadDate;
  int workloadDifficulty;
  int complete;

  Workload(
      {this.workloadID, this.subject, this.workloadName, this.workloadNumber, this.workloadDate, this.workloadDifficulty, this.complete});

  Map<String, dynamic> toMap(){
    return{
      '_workloadID': workloadID,
      'subject':subject,
      'workloadName' : workloadName,
      'workloadNumber' : workloadNumber,
      'workloadDate' : workloadDate,
      'workloadDifficulty' : workloadDifficulty,
      'complete': complete,
    };
  }

}

Future<List<Workload>> updateWorkloadList()async{
  var tempList = DatabaseHelper.instance.queryAllWorkloads();
  return tempList;
}

Future<List<Workload>> workloadListBySubject(String subjectName)async{
  var tempList = DatabaseHelper.instance.returnWorkloadsForSubject(subjectName);
  return tempList;
}
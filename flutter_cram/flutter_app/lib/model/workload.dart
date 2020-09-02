import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/model/subject.dart';

class Workload {
  final int workloadID;
  final String subject;
  final String workloadName;
  final int workloadNumber;
  String workloadDate;
  int workloadDifficulty;
  final int complete;

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

//List<Workload> updateTestWorkloadList(){
//  //CREATE WORKLOADS
//  List<Workload> testWl = [];
//  int workloadID = 0;
//
//  for (Subject s in MainScreen.test_subjects) {
//    for (int i = 0; i < s.workloads; i++) {
//      testWl.add(
//          Workload(
//            workloadID: workloadID,
//            subject: s.name,
//            workloadName: (i + 1).toString(),
//            workloadNumber: i + 1,
//            workloadDate: null,
//            workloadDifficulty: s.difficulty,
//            complete: 0,
//          )
//      );
//
//      workloadID += 1;
//    }
//  }
//  return testWl;
//}
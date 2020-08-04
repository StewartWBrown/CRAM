import 'package:flutter_app/database/databaseHelper.dart';

class Workload {
  final int workloadID;
  final String subject;
  final String workloadName;
  final int workloadNumber;
  final int complete;

  Workload(
      {this.workloadID, this.subject, this.workloadName, this.workloadNumber, this.complete});

  Map<String, dynamic> toMap(){
    return{
      '_workloadID': workloadID,
      'subject':subject,
      'workloadName' : workloadName,
      'workloadNumber' : workloadNumber,
      'complete': complete,
    };
  }

}
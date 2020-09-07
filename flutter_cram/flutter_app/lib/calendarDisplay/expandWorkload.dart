import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/workload.dart';

class ExpandWorkload extends StatelessWidget{

  final Workload workload;
  ExpandWorkload(this.workload);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(workload.workloadName),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Date: " + workload.workloadDate),
          Text("\nSubject: " + workload.subject),
//          Checkbox(
//            value: null,
//          ),
        ],
      ),
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

  }

}
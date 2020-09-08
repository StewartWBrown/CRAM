import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/model/workload.dart';

class ExpandWorkload extends StatefulWidget{

  final Workload workload;
  ExpandWorkload(this.workload);

  @override
  _ExpandWorkloadState createState() => _ExpandWorkloadState();
}

class _ExpandWorkloadState extends State<ExpandWorkload> {

  bool isComplete;

  void initState(){
    super.initState();

    //CHANGE COMPLETE TO BOOL INSTEAD OF 0/1 WILL BE SO MUCH CLEANER
    if(widget.workload.complete==0){
      isComplete = false;
    }
    else{
      isComplete = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(widget.workload.workloadName),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Date: " + widget.workload.workloadDate),
          Text("\nSubject: " + widget.workload.subject),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("\nComplete?"),
              Checkbox(
                value: isComplete,
                onChanged: (bool value) {
                  setState(() {
                    isComplete = value;
                  });
                  updateWl(widget.workload, isComplete);
                },
              ),
            ],

          ),
        ],
      ),
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

  }


  updateWl(Workload wl, bool isComplete) {
    int val;
    if(isComplete==false){
      val=0;
    }
    else{
      val=1;
    }

    //UPDATE DATE INTO WORKLOADS TABLE HERE
    var updatedWorkload = Workload(
      workloadID : wl.workloadID,
      subject : wl.subject,
      workloadName : wl.workloadName,
      workloadNumber : wl.workloadNumber,
      workloadDate : wl.workloadDate,
      workloadDifficulty : wl.workloadDifficulty,
      complete : val,
    );
    DatabaseHelper.instance.updateWorkload(updatedWorkload);
  }


}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/calendarDisplay/expandWorkload.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/model/workload.dart';

class CompletedWorkloads extends StatefulWidget{

  List<Workload> _workloads;
  CompletedWorkloads(this._workloads);

  @override
  _CompletedWorkloadsState createState() => _CompletedWorkloadsState();
}

class _CompletedWorkloadsState extends State<CompletedWorkloads> {

  ExpandWorkload _expandWorkload;
  List<Workload> completedWorkloads;

  void initState(){
    super.initState();
    completedWorkloads = [];

    for(Workload wl in widget._workloads){
      if(wl.complete == 1){
        completedWorkloads.add(wl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Completed Workloads"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        ... completedWorkloads.map((event) => ListTile(
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
      ),

      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
  }
}
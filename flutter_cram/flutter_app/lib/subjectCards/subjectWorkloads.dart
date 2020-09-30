import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';

class SubjectWorkloads extends StatefulWidget{
  final Subject subject;
  final Color diffColor;

  const SubjectWorkloads(this.subject, this.diffColor);

  @override
  _SubjectWorkloadsState createState() => _SubjectWorkloadsState();
}

class _SubjectWorkloadsState extends State<SubjectWorkloads> {

  @override
  Widget build(BuildContext context) {
    Future<List<Workload>> _workloads = workloadListBySubject(widget.subject.name);
    return AlertDialog(
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        //subject name
        Text(
        widget.subject.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),

      //difficulty circle
      Align(
        alignment: Alignment.topCenter,
        child:
        RawMaterialButton(
          fillColor: widget.diffColor,
          child:
          Text(
            widget.subject.difficulty.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          padding: EdgeInsets.all(0.0),
          shape: CircleBorder(),
          onPressed: () {},
        ),
      ),
        FutureBuilder(
          future: _workloads,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            else{
              List<Workload> _workloads = snapshot.data ??  [];
              return Text(_workloads[0].workloadName);
            }

            return Container(

            );
          }
      ),
  ],
    ),
    );

  }
}

/**
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    //subject name
    Text(
    widget.subject.name,
    textAlign: TextAlign.center,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
    ),
    ),

    //difficulty circle
    Align(
    alignment: Alignment.topCenter,
    child:
    RawMaterialButton(
    fillColor: widget.diffColor,
    child:
    Text(
    widget.subject.difficulty.toString(),
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
    ),
    ),
    padding: EdgeInsets.all(0.0),
    shape: CircleBorder(),
    onPressed: () {},
    ),
    ),


    FutureBuilder(
    future: _workloads,
    builder: (context, snapshot) {
    switch (snapshot.connectionState) {
    case ConnectionState.none:
    case ConnectionState.waiting:
    return Center(
    child: CircularProgressIndicator()
    );
    default:
    if(snapshot.hasData){
    List<Workload> _workloads = snapshot.data ?? [];
    print(_workloads);
    }
    else if(snapshot.hasError){
    print("AHHHHHHHHH");
    }

    return Container(

    );
    }
    }
    ),
    ],
    ),
    );
    }
    }

 **/
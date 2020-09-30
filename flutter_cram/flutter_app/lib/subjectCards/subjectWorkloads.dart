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

      content: FutureBuilder(
          future: _workloads,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            else{
              print(snapshot.toString());
            }

            return Container(

            );
          }
      ),

    );
  }
}

/**



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
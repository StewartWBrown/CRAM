import 'package:flutter_app/calendarDisplay/expandWorkload.dart';
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

              List incompleteWl = checkIfComplete(_workloads, 0);
              List completeWl = checkIfComplete(_workloads, 1);
              return Column(
                children: <Widget>[

                  SizedBox(height: 10),

                  Text(
                    "Still to do",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                    ),
                  ),

                  Container(
                    height: 300.0,
                    width: 300.0,
                    child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0),
                          sliver: new SliverList(
                            delegate: new SliverChildBuilderDelegate(
                                  (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    var expandWorkload = ExpandWorkload(incompleteWl[index]);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context){
                                        return expandWorkload;
                                      },
                                    );
                                  },
                                  child:
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    color: Colors.orangeAccent,
                                    child: Text(incompleteWl[index].workloadName),
                                  ),
                                );
                              },
                              childCount: incompleteWl.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Completed",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                    ),
                  ),

                  Container(
                    height: 300.0,
                    width: 300.0,
                    child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0),
                          sliver: new SliverList(
                            delegate: new SliverChildBuilderDelegate(
                                  (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    var expandWorkload = ExpandWorkload(completeWl[index]);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context){
                                        return expandWorkload;
                                      },
                                    );
                                  },
                                  child:
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    color: Colors.orangeAccent,
                                    child: Text(
                                      completeWl[index].workloadName,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: completeWl.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              );
            }
          }),
        ],
      ),
    );
  }
}

List checkIfComplete(List workloads, int isComplete){
  List finalList = [];
  for(Workload wl in workloads){
    if(wl.complete == isComplete){
      finalList.add(wl);
    }
  }
  return finalList;
}

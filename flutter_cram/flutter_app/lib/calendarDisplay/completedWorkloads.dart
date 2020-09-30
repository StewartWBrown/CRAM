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
                            var expandWorkload = ExpandWorkload(completedWorkloads[index]);
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
                            child: Text(completedWorkloads[index].workloadName),
                          ),
                        );
                      },
                      childCount: completedWorkloads.length,
                    ),
                  ),
                ),
              ],
            ),
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
}
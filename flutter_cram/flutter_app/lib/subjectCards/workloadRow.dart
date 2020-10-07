import 'package:flutter/material.dart';
import 'package:flutter_app/calendarDisplay/expandWorkload.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';
import 'package:intl/intl.dart';

class WorkloadRow extends StatelessWidget {

  final Workload workload;
  final Subject subject;


  var dateFormExamDate;
  
  WorkloadRow(this.workload, this.subject);

  @override
  Widget build(BuildContext context) {
    if(workload.workloadDate != "NONE") {
      dateFormExamDate = DateTime.parse(workload.workloadDate);
    }



    // Subject subject = DatabaseHelper.instance.
    String colourValueString = subject.colour.split('(0x')[1].split(')')[0];
    int value = int.parse(colourValueString, radix: 16);
    Color subjectColour = new Color(value);

    IconData subjectIcon = IconData(subject.icon, fontFamily: 'MaterialIcons');


    final workloadThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: RawMaterialButton(
        elevation: 0.0,
        fillColor: Colors.white,
        child: Icon(
          subjectIcon,
          size: 30.0,
        ),
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),
      ),
    );

    final workloadCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          workload.complete == 0 ?
          Text(workload.workloadName) :
            Text(
              workload.workloadName,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),
          new Container(height: 10.0),

          workload.complete == 0 ? Text(workload.workloadDate == "NONE" ? "NO DATE" : new DateFormat.yMMMd().format(dateFormExamDate)):

            Text("COMPLETE"),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)
          ),

        ],
      ),
    );

    final workloadCard = new GestureDetector(
        onTap: (){
          var expandWorkload = ExpandWorkload(workload);

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context){
              return expandWorkload;
            },
          );
        },
        child: new Container(
          child: workloadCardContent,
          height: 124.0,
          margin: new EdgeInsets.only(left: 46.0),
          decoration: new BoxDecoration(
            color: subjectColour,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: subjectColour,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),
        )
    );

    return new Container(
        height: 100.0,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            workloadCard,
            workloadThumbnail,
          ],
        )
    );
  }
}
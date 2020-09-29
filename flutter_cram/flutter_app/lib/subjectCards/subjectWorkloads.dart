import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';

class SubjectWorkloads extends StatelessWidget{
  Color diffColor;
  Subject subject;

  SubjectWorkloads(this.subject, this.diffColor);

  @override
  Widget build(BuildContext context) {
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
          subject.name,
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
            fillColor: diffColor,
            child:
            Text(
              subject.difficulty.toString(),
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
        ]),



    );
  }
}
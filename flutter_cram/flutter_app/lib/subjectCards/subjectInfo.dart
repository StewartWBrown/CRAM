import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:intl/intl.dart';

class SubjectInfo extends StatelessWidget{
  Color diffColor;
  Subject subject;

  SubjectInfo(this.subject, this.diffColor);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),

      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

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

          SizedBox(height: 30),

          //start date
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Start Date:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              dateFormatter(subject.startDate),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),

          SizedBox(height: 30),

          //end date
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "End Date:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              dateFormatter(subject.endDate),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),

          SizedBox(height: 30),

          //exam date
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Exam Date:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              dateFormatter(subject.examDate),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),
        ],
      ),



    );
  }

}

String dateFormatter(String date){
  DateTime d = DateTime.parse(date);
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  String formatted = formatter.format(d);
  return formatted;
}
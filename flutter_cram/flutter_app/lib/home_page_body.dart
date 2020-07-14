import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'subject_row.dart';

class HomePageBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return new Column(
     children: <Widget>[
       new SubjectRow(subjects[0]),
       new SubjectRow(subjects[1]),
       new SubjectRow(subjects[2]),
       new SubjectRow(subjects[3]),
     ]
   );
  }
}
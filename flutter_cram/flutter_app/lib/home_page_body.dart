import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'subject_row.dart';

class HomePageBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return new Column(
     children: <Widget>[

       // Loop through list of subjects, creating a row for each one
       for(var subject in subjects) new SubjectRow(subject)

     ]
   );
  }
}
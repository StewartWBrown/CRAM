import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'subject_row.dart';

class HomePageBody extends StatelessWidget{
  Future<List<Subject>> subjects = updateList();

  @override
  Widget build(BuildContext context) {
        someFunc() async{
          for(Subject subject in subjects){
            new SubjectRow(subject);
          }
        };
}

}
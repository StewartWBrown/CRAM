import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'subject_row.dart';

class HomePageBody extends StatelessWidget{
  Future<List<Subject>> subjects = updateList();

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
          FutureBuilder<List<Subject>>(
            future: subjects,
            builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done){
               // return loading state
              }
              if(snapshot.hasError){
                // return error widget
              }
              List<Subject> subjects = snapshot.data ?? [];
              if (subjects.isEmpty){
                return Text("Enter a subject bitch");
              }
              for(Subject subject in subjects){
                new SubjectRow(subject);
              }

              return Container(width: 0.0, height: 0.0);
            }

          )




      ]
    );
}

}
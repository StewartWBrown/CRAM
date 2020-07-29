import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expandSubjectCard.dart';
import 'package:flutter_app/model/subject.dart';

class SubjectRow extends StatelessWidget {

  final Subject subject;

  SubjectRow(this.subject);


  @override
  Widget build(BuildContext context) {

    var dateFormExamDate = DateTime.parse(subject.examDate);

    final subjectThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
    );

    final subjectCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(subject.name),
          new Container(height: 10.0),
          new Text(new DateFormat.yMMMd().format(dateFormExamDate)),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)
          ),

            ],
          ),
      );

    final subjectCard = new GestureDetector(
      onTap: (){
        var expandSubject = ExpandSubjectCard(subject);

        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context){
            return expandSubject;
          },
        );
      },
      child: new Container(
        child: subjectCardContent,
        height: 124.0,
        decoration: new BoxDecoration(
          color: new Color(0xFF18aff5),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(4.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),
      )
    );

    return new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            subjectCard,
            subjectThumbnail,
          ],
        )
    );
  }
}
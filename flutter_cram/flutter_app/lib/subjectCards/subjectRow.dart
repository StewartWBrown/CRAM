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
    String colourValueString = subject.colour.split('(0x')[1].split(')')[0];
    int value = int.parse(colourValueString, radix: 16);
    Color subjectColour = new Color(value);

    final subjectThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: RawMaterialButton(
        elevation: 0.0,
        fillColor: Colors.white,
        child: Icon(
          Icons.pregnant_woman,
          size: 40.0,
        ),
        padding: EdgeInsets.all(25.0),
        shape: CircleBorder(),
      ),
    );

    final subjectCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
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
              color: new Color(0xff00c6ff),
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
        margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
          color: subjectColour,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
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
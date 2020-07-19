import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'subject_row.dart';

class HomePageBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    Expanded(
      child: new Container(
        color: new Color(0xFF0c6f96),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new SubjectRow(subjects[index]),
                  childCount: subjects.length,
                ),
              ),
            ),
          ],
        ),
      ),
    )]);
  }
}
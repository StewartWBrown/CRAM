import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'subject_row.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  Future<List<Subject>> subjects = updateList();
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Subject>>(
          future: subjects,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator()
                );
              default:
                List<Subject> subjects = snapshot.data ?? [];
                if (subjects.isEmpty) {
                  return Text("Enter a subject bitch");
                }
                else {
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  sliver: new SliverList(
                                    delegate: new SliverChildBuilderDelegate(
                                          (context, index) =>
                                      new SubjectRow(subjects[index]),
                                      childCount: subjects.length,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]);
                }
            }
          }
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'addSubject.dart';
import 'subjectRow.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  Future<List<Subject>> subjects = updateList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSubject()),
          );
        },
        label: Text('Add Subject'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Subject>>(
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

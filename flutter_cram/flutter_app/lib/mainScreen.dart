import 'package:flutter/material.dart';
import 'home_page_body.dart';
import 'addSubject.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRAM',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CRAM STUDYING'),
        ),
        body: new Column(
          children: <Widget>[
            new HomePageBody(),
          ],

        ),
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
      ),

    );
  }
}


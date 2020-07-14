import 'package:flutter/material.dart';

class AddSubject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRAM',
      home: Scaffold(
        appBar: AppBar(
          title: Text('AHHHHHHH'),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text('Done'),
          icon: Icon(Icons.done),
          backgroundColor: Colors.green,
        ),
      ),

    );
  }
}


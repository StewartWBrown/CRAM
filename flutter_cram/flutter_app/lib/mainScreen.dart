import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRAM',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CRAM STUDYING'),
        ),
        body: Body(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Add Subject'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),

    );
  }
}


/// This is the stateless widget that the main application instantiates.
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 4,
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Web Science", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Total Workloads: 5", style: TextStyle(color: Colors.white70)),
                Text("Workloads Left: 3", style: TextStyle(color: Colors.white70)),
                Text("Exam Date: 13/07/2020", style: TextStyle(color: Colors.white70)),
              ],
            ),
            Spacer(),
            CircleAvatar(backgroundColor: Colors.white),
          ],
        ),
      ),
    );
  }
}


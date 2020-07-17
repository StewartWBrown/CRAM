import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:intl/intl.dart';

class AddSubject extends StatefulWidget {
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  String tempName;
  int tempWorkloads;
  List<int> tempWorkCompleted;
  int tempDifficulty;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime examDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Subject Name'),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Subject name is required';
        }
      },
      onSaved: (String value) {
        tempName = value;
      },
    );
  }

  Widget _buildWorkloads() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Number of workloads'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value) {
        int wl = int.tryParse(value);

        if (wl == null || wl <= 0) {
          return 'Workload number must in fact be... a number. loser.';
        }
      },

      onSaved: (String value) {
        tempWorkloads = int.tryParse(value);
      },
    );
  }

  Widget _buildDifficulty() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Difficulty of subject (1 being easy, 3 being hard)'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value) {
        int dif = int.tryParse(value);

        if (dif == null || dif < 1 || dif > 3) {
          return 'Difficulty must be either 1, 2 or 3';
        }
      },
      onSaved: (String value) {
        tempDifficulty = int.tryParse(value);
      },
    );
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

        if(_selDate!=null){
          setState((){
            startDate =_selDate;

          });
        }
  }


  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2100));

    if(_selDate!=null){
      setState((){
        endDate =_selDate;
      });
    }
  }


  Future<Null> _selectExamDate(BuildContext context) async {
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: endDate,
        lastDate: DateTime(2100));

    if(_selDate!=null){
      setState((){
        examDate =_selDate;
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {

   String formattedStartDate = new DateFormat.yMMMd().format(startDate);
   String formattedEndDate = new DateFormat.yMMMd().format(endDate);
   String formattedExamDate = new DateFormat.yMMMd().format(examDate);

    return MaterialApp(
      title: 'CRAM',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add a subject"),
        ),
        body: Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildName(),
                      _buildWorkloads(),
                      _buildDifficulty(),
                      SizedBox(height: 20),
                      Row(children: <Widget>[
                        Text('Date to start studying: $formattedStartDate'),
                        SizedBox(width: 55),
                        IconButton(
                            onPressed: () {
                              _selectStartDate(context);
                            },
                            icon: Icon(Icons.calendar_today))
                      ]),
                      SizedBox(height: 20),
                      Row(children: <Widget>[
                        Text('Date to finish studying: $formattedEndDate'),
                        SizedBox(width: 50),
                        IconButton(
                            onPressed: () {
                              _selectEndDate(context);
                            },
                            icon: Icon(Icons.calendar_today))
                      ]),

                      SizedBox(height: 20),
                      Row(children: <Widget>[
                        Text('Exam date: $formattedExamDate'),
                        SizedBox(width: 112),
                        IconButton(
                            onPressed: () {
                              _selectExamDate(context);
                            },
                            icon: Icon(Icons.calendar_today))
                      ]),

                      SizedBox(height: 100),
                      RaisedButton(
                          child: Text('Add Subject'),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }

                            _formKey.currentState.save();
                            print(tempName);

                          })
                    ]))),
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

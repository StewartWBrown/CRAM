import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import '../model/workload.dart';
import '../main/main.dart';

class AddSubject extends StatefulWidget {
  Subject subject;
  AddSubject([this.subject]);

  _AddSubjectState createState() => _AddSubjectState(subject);

}

class _AddSubjectState extends State<AddSubject> {
  Subject subject;
  _AddSubjectState(this.subject);

  String initialName = "";
  String initialWorkloads = "";
  String initialWorkCompleted = "";
  String initialDifficulty = "";

  String tempName;
  int tempWorkloads;
  List<int> tempWorkCompleted;
  int tempDifficulty;
  DateTime now = DateTime.now();
  String startDate;
  String endDate;
  String examDate;

  DateTime startPicker;
  DateTime endPicker;
  DateTime examPicker;
  Future<List<Workload>> workloads = updateWorkloadList();


  @override
  void initState() {
    super.initState();
    if(subject != null){
      initialName = subject.name;
      initialWorkloads = subject.workloads.toString();
      initialDifficulty = subject.difficulty.toString();
      startDate = subject.startDate;
      endDate = subject.endDate;
      examDate = subject.examDate;
    }
    else{
      startPicker = DateTime(now.year, now.month, now.day);
      endPicker = DateTime(now.year, now.month, now.day);
      examPicker = DateTime(now.year, now.month, now.day);
    }
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Subject Name',
      ),
      initialValue: initialName,
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
      decoration: InputDecoration(
        labelText: 'Number of workloads',
      ),
      initialValue: initialWorkloads,
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
        labelText: 'Difficulty of subject (1 being easy, 3 being hard)',
      ),
      initialValue: initialDifficulty,
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
        initialDate: startPicker,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

        if(_selDate!=null){
          setState((){
            startPicker =_selDate;

          });
        }
  }


  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: startPicker,
        firstDate: startPicker,
        lastDate: DateTime(2100));

    if(_selDate!=null){
      setState((){
        endPicker =_selDate;
      });
    }
  }


  Future<Null> _selectExamDate(BuildContext context) async {
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: endPicker,
        firstDate: endPicker,
        lastDate: DateTime(2100));

    if(_selDate!=null){
      setState((){
        examPicker =_selDate;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

   String formattedStartDate = new DateFormat.yMMMd().format(startPicker);
   String formattedEndDate = new DateFormat.yMMMd().format(endPicker);
   String formattedExamDate = new DateFormat.yMMMd().format(examPicker);

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

                      //SizedBox(height: 100),
                      RaisedButton(
                          child: Text('Add Subject'),
                          onPressed: () async{
                            if (!_formKey.currentState.validate()) {
                              return;
                            }

                            _formKey.currentState.save();

                            // Create subject object
                          var newSubject = Subject(
                            name: tempName,
                            workloads: tempWorkloads,
                            difficulty: tempDifficulty,
                            startDate: startPicker.toString(),
                            endDate: endPicker.toString(),
                            examDate: examPicker.toString(),
                          );

                          // Add subject object to database
                          await DatabaseHelper.instance.insertSubject(newSubject);

                          // Create workload object for each workload to be created
                            // the for loop is ugly here (starting at 1 instead of 0) because the workload number should start from 1
                          for( var counter = 1 ; counter < tempWorkloads+1; counter++ ) {
                            var newWorkload = Workload(
                              workloadID: null,
                              subject: tempName,
                              workloadName: "$tempName workload $counter",
                              workloadNumber: counter,
                              workloadDifficulty: tempDifficulty,
                              workloadDate: "NONE",
                              complete: 0,
                            );

                            // Add workload instance to database
                            await DatabaseHelper.instance.insertWorkload(newWorkload);
                          }


                          })
                    ]))),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CramApp()));

          },
          label: Text('Done'),
          icon: Icon(Icons.done),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}

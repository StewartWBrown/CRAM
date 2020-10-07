import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:intl/intl.dart';
import '../database/databaseHelper.dart';


import 'expandSubjectCard.dart';

class EditSubject extends StatefulWidget {
  Subject subject;
  EditSubject([this.subject]);

  _EditSubjectState createState() => _EditSubjectState(subject);

}
class _EditSubjectState extends State<EditSubject> {
  final Subject subject;

  _EditSubjectState(this.subject);

  String initialName = "";
  String initialWorkloads = "";
  String initialWorkCompleted = "";
  String initialDifficulty = "";

  // If the name is changed, since name is the primary key, the row is deleted and a new one created
  bool nameChange;

  String tempName;
  int tempWorkloads;
  List<int> tempWorkCompleted;
  int tempDifficulty;

  String startDate;
  String endDate;
  String examDate;

  String tempStartDate;
  String tempEndDate;
  String tempExamDate;

  DateTime startPicker;
  DateTime endPicker;
  DateTime examPicker;

  @override
  void initState() {
    super.initState();
    if(subject != null){
      initialName = subject.name;
      initialWorkloads = subject.workloads.toString();
      initialDifficulty = subject.difficulty.toString();
      tempName = subject.name;
      tempWorkloads = subject.workloads;
      tempDifficulty = subject.difficulty;

      startPicker = DateTime.parse(subject.startDate);
      endPicker = DateTime.parse(subject.endDate);
      examPicker = DateTime.parse(subject.examDate);
      startDate = new DateFormat.yMMMd().format(startPicker);
      tempStartDate = startDate;
      endDate = new DateFormat.yMMMd().format(endPicker);
      tempEndDate = endDate;
      endDate = new DateFormat.yMMMd().format(examPicker);
      tempExamDate = examDate;

      nameChange= false;

    }
  }

  final GlobalKey<FormState> _EditformKey = GlobalKey<FormState>();

  Widget _rebuildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Subject Name",
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
        if(value != initialName){
          nameChange = true;
        }
      },
    );
  }

  Widget _rebuildWorkloads() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Number of workloads",
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

  Widget _rebuildDifficulty() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Difficulty",
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
        if(value != initialDifficulty){
          // difficultyChange = true;
        }
      },
    );
  }

  Future<Null> _reselectStartDate(BuildContext context) async {
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

  Future<Null> _reselectEndDate(BuildContext context) async {
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
  Future<Null> _reselectExamDate(BuildContext context) async {
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
    String tempStartDate = new DateFormat.yMMMd().format(startPicker);
    String tempEndDate = new DateFormat.yMMMd().format(endPicker);
    String tempExamDate = new DateFormat.yMMMd().format(examPicker);

    return AlertDialog(
      title: Text("Editing " + subject.name),

      content: Container(
    child: Form(
    key: _EditformKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _rebuildName(),
        _rebuildWorkloads(),
        _rebuildDifficulty(),
        SizedBox(height: 20),
        Row(children: <Widget>[
          Text('Date to start studying: $tempStartDate'),
          SizedBox(width: 10),
          IconButton(
              onPressed: () {
                _reselectStartDate(context);
              },
              icon: Icon(Icons.calendar_today))
        ]),
        SizedBox(height: 20),
        Row(children: <Widget>[
          Text('Date to finish studying: $tempEndDate'),
          SizedBox(width: 10),
          IconButton(
              onPressed: () {
                _reselectEndDate(context);
              },
              icon: Icon(Icons.calendar_today))
        ]),

        SizedBox(height: 20),
        Row(children: <Widget>[
          Text('Exam date: $tempExamDate'),
          SizedBox(width: 40),
          IconButton(
              onPressed: () {
                _reselectExamDate(context);
              },
              icon: Icon(Icons.calendar_today))
        ]),
      ],
    )
    )),


      actions: <Widget>[
        // Line to redirect to subject half full idk if that works
        // MaterialPageRoute(builder: (context) => AddSubject(subject)
        FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ),
        FlatButton(
          child: Text(
            "Save Changes",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async{
            if (!_EditformKey.currentState.validate()) {
              return;
            }

            _EditformKey.currentState.save();

            var updatedSubject = Subject(
              name: tempName,
              workloads: tempWorkloads,
              difficulty: tempDifficulty,
              startDate: startPicker.toString(),
              endDate: endPicker.toString(),
              examDate: examPicker.toString(),
            );

            if(tempName == subject.name){
              print("Went this way");
              await DatabaseHelper.instance.updateSubject(updatedSubject);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
            }
            else {
              await DatabaseHelper.instance.deleteSubject(subject.name);
              await DatabaseHelper.instance.insertSubject(updatedSubject);
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen()));
            }
          },
        )
      ],
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

  }


}


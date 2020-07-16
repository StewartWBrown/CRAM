import 'package:flutter/material.dart';
import 'package:flutter_app/model/subject.dart';

class AddSubject extends StatelessWidget {

  String tempName;
  int tempWorkloads;
  List<int> tempWorkCompleted;
  int tempDifficulty;
  DateTime tempStartDate;
  DateTime tempEndDate;
  DateTime tempExamDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Subject Name'),
      // ignore: missing_return
      validator: (String value){
        if(value.isEmpty){
          return 'Subject name is required';
        }
      },
      onSaved: (String value){
        tempName = value;
      },
    );
  }

  Widget _buildWorkloads(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Number of workloads'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value){

        int wl = int.tryParse(value);

        if(wl == null || wl <= 0){
          return 'Workload number must in fact be... a number. loser.';
        }
      },

      onSaved: (String value){
        tempWorkloads = int.tryParse(value);
      },
    );
  }

  Widget _buildDifficulty(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Difficulty of subject (1 being easy, 3 being hard)'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value){

        int dif = int.tryParse(value);

        if(dif == null || dif < 1 || dif > 3){
          return 'Difficulty must be either 1, 2 or 3';
        }
      },
      onSaved: (String value){
        tempDifficulty = int.tryParse(value);
      },
    );;
  }

  Widget _buildStart(){

  }

  Widget _buildEnd(){
    return null;
  }

  Widget _buildExam(){
    return null;
  }


  @override
  Widget build(BuildContext context) {
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
              // _buildStart(),
              //_buildEnd(),
              //_buildExam(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text('Add Subject'),
                onPressed: () {
                  if(!_formKey.currentState.validate()){
                    return;
                  }

                  _formKey.currentState.save();
                  print(tempName);
                }
                )
            ]
          ))
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


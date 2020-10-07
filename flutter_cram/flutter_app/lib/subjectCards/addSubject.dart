import 'package:flutter/material.dart';
import 'package:flutter_app/main/futureArea.dart';
import 'package:flutter_app/main/mainScreen.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import '../model/workload.dart';
import 'duplicateSubject.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

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
  ColorSwatch _mainColour = Colors.blue;
  Color _shadeColour = Colors.blue[800];
  ColorSwatch _tempMainColour;
  Color _tempShadeColour;

  Icon iconToDisplay;
  int iconToStore;

  DateTime startPicker;
  DateTime endPicker;
  DateTime examPicker;

  int isDuplicate;


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

  Widget _buildColour(BuildContext context){
    return MaterialColorPicker(
        onColorChange: (Color color) {
          // Handle color changes
        },
        onMainColorChange: (ColorSwatch color) {
          // Handle main color changes
        },
        selectedColor: Colors.red
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

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context, iconPackMode: IconPack.material);
    iconToStore = icon.codePoint;
    iconToDisplay = Icon(icon);
    setState((){});
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

  void _openDialog(String title, Widget content) {
    showDialog(context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content:content,
          actions: [
          FlatButton(
          child: Text('CANCEL'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog')
        ),
          FlatButton(
            child: Text('SUBMIT'),
            onPressed: () {Navigator.of(context, rootNavigator: true).pop('dialog');
            setState(() => _mainColour = _tempMainColour);
            setState(() => _shadeColour = _tempShadeColour);
           }

        ),
        ],
          );
      },
    );
  }

    void _openColourPicker() async{
      _openDialog("Colour Picker",
      Container(height:250,
      child:
      MaterialColorPicker(
        selectedColor: _shadeColour,
        onColorChange: (color) => setState(() => _tempShadeColour = color),
        onMainColorChange: (color) => setState(() => _tempMainColour = color),
        onBack: () => print("Back button pressed"),
      )
      ),
      );
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: _shadeColour,
                            radius: 35.0,
                          ),
                        ],
                      ),
                      const SizedBox(width: 32.0),
                      OutlineButton(
                        onPressed: _openColourPicker,
                        child: const Text('Pick subject colour'),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: iconToDisplay != null ? iconToDisplay : Container()
                      ),
                      SizedBox(width: 60),
                      OutlineButton(
                        onPressed: _pickIcon,
                        child: Text('Pick subject Icon'),
                      ),

                  ],
                ),



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
                            colour: _shadeColour.toString(),
                            icon: iconToStore,
                          );

                          if(await DatabaseHelper.instance.isDuplicate(tempName)){
                            var duplicateInstance = DuplicateSubject(newSubject);

                            showDialog(context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return duplicateInstance;
                              },
                            );
                            return;
                          }
                          else {
                            // Add subject object to database
                            await DatabaseHelper.instance.insertSubject(newSubject);

                            // Add subject to local Subject list
                            localSubjects.add(newSubject);

                            // Create workload object for each workload to be created
                            // the for loop is ugly here (starting at 1 instead of 0) because the workload number should start from 1
                            for (var counter = 1; counter < tempWorkloads + 1; counter++) {
                              var newWorkload = Workload(
                                workloadID: null,
                                subject: tempName,
                                workloadName: "$tempName workload $counter",
                                workloadNumber: counter,
                                workloadDifficulty: tempDifficulty,
                                workloadDate: "NONE",
                                complete: 0,
                              );

                              var newLocalWorkload = Workload(
                                workloadID: wlID,
                                subject: tempName,
                                workloadName: "$tempName workload $counter",
                                workloadNumber: counter,
                                workloadDifficulty: tempDifficulty,
                                workloadDate: "NONE",
                                complete: 0,
                              );

                              // Add workload instance to database
                              print("db: " + newWorkload.workloadName);
                              print("local: " + newLocalWorkload.workloadName);

                              await DatabaseHelper.instance.insertWorkload(newWorkload);
                              localWorkloads.add(newLocalWorkload);
                              wlID += 1;
                            }
                          }
                          })
                    ]))),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
          },
          label: Text('Done'),
          icon: Icon(Icons.done),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}

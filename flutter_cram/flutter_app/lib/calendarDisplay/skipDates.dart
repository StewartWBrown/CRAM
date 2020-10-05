import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/databaseHelper.dart';

class SkipDates extends StatefulWidget{
  @override
  _SkipDatesState createState() => _SkipDatesState();

}

class _SkipDatesState extends State<SkipDates>{
  Future<List> skipDatabase;
  int mon;
  int tue;
  int wed;
  int thu;
  int fri;
  int sat;
  int sun;

  void initState(){
    super.initState();
    skipDatabase = DatabaseHelper.instance.queryAllSkipDays();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),

      content: FutureBuilder(
        future: skipDatabase,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator()
              );
            default:
              List skipValues = snapshot.data ?? [];
              print(skipValues);

              mon = skipValues[0];
              tue = skipValues[1];
              wed = skipValues[2];
              thu = skipValues[3];
              fri = skipValues[4];
              sat = skipValues[5];
              sun = skipValues[6];

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Skip Dates",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Monday
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            int x = (mon == 0 ? 1 : 0);
                            DatabaseHelper.instance.skipDay("Monday", x);
                            skipValues[0] = x;
                          });
                        },
                        elevation: 40.0,
                        fillColor: mon == 0 ? Colors.white : Colors. red,
                        child: Text(
                          "MON",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),

                      //SizedBox(width: 10),

                      //Tuesday
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.white,
                        child: Text(
                          "TUE",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),

                      //SizedBox(width: 10),

                      //Wednesday
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.white,
                        child: Text(
                          "WED",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),

                      //SizedBox(width: 10),

                      //Thursday
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.white,
                        child: Text(
                          "THU",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Friday
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.white,
                        child: Text(
                          "FRI",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),

                      //SizedBox(width: 10),

                      //Saturday
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.white,
                        child: Text(
                          "SAT",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),

                      //SizedBox(width: 10),

                      //Sunday
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.white,
                        child: Text(
                          "SUN",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                        },
                        elevation: 40.0,
                        fillColor: Colors.green,
                        child: Icon(
                          Icons.done,
                          size: 40.0,
                        ),
                        padding: EdgeInsets.all(25.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ],
              );
          }
        }

      ),




    );
  }

}
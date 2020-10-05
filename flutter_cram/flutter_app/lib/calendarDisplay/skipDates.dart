import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/main/futureArea.dart';

class SkipDates extends StatefulWidget{
  @override
  _SkipDatesState createState() => _SkipDatesState();
}

class _SkipDatesState extends State<SkipDates>{
  int mon;
  int tue;
  int wed;
  int thu;
  int fri;
  int sat;
  int sun;

  @override
  Widget build(BuildContext context) {

    mon = localSkipDays[0];
    tue = localSkipDays[1];
    wed = localSkipDays[2];
    thu = localSkipDays[3];
    fri = localSkipDays[4];
    sat = localSkipDays[5];
    sun = localSkipDays[6];

    return AlertDialog(
      elevation: 24.0,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),

      content: Column(
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
                      localSkipDays[0] = x;
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
                    setState(() {
                      int x = (tue == 0 ? 1 : 0);
                      DatabaseHelper.instance.skipDay("Tuesday", x);
                      localSkipDays[1] = x;
                    });
                  },
                  elevation: 40.0,
                  fillColor: tue == 0 ? Colors.white : Colors. red,
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
                    setState(() {
                      int x = (wed == 0 ? 1 : 0);
                      DatabaseHelper.instance.skipDay("Wednesday", x);
                      localSkipDays[2] = x;
                    });
                  },
                  elevation: 40.0,
                  fillColor: wed == 0 ? Colors.white : Colors. red,
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
                    setState(() {
                      int x = (thu == 0 ? 1 : 0);
                      DatabaseHelper.instance.skipDay("Thursday", x);
                      localSkipDays[3] = x;
                    });
                  },
                  elevation: 40.0,
                  fillColor: thu == 0 ? Colors.white : Colors. red,
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
                    setState(() {
                      int x = (fri == 0 ? 1 : 0);
                      DatabaseHelper.instance.skipDay("Friday", x);
                      localSkipDays[4] = x;
                    });
                  },
                  elevation: 40.0,
                  fillColor: fri == 0 ? Colors.white : Colors. red,
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
                    setState(() {
                      int x = (sat == 0 ? 1 : 0);
                      DatabaseHelper.instance.skipDay("Saturday", x);
                      localSkipDays[5] = x;
                    });
                  },
                  elevation: 40.0,
                  fillColor: sat == 0 ? Colors.white : Colors. red,
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
                    setState(() {
                      int x = (sun == 0 ? 1 : 0);
                      DatabaseHelper.instance.skipDay("Sunday", x);
                      localSkipDays[6] = x;
                    });
                  },
                  elevation: 40.0,
                  fillColor: sun == 0 ? Colors.white : Colors. red,
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
        ),
    );
  }

}
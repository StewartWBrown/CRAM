import 'dart:collection';

import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';

class Spread {

  Map<DateTime, Map<String, List<Workload>>> spread(List<Subject> subjects, List<DateTime> skipDates){

    //add exam dates to skipDates list
    for(int i=0; i<subjects.length; i++){
      if(!skipDates.contains(subjects[i].examDate)){
        skipDates.add(subjects[i].examDate);
      }
    }

    //initially, spread workloads for subject between remaining study dates given
    Map<DateTime, Map<String, List<Workload>>> calendar = Map();
    for (Subject subject in subjects){
      int totalDays = subject.endDate.difference(subject.startDate).inDays;

      //if exam date within startDate and endDate, decrease studyTime (days) by 1 day
      for (DateTime date in skipDates){
        if(date.isAfter(subject.startDate) && date.isBefore(subject.endDate)){
          totalDays -= 1;
        }
      }

      //evenly spread remaining workload between available days
      int workPosition = 0;
      DateTime dateToStore;
      double skipValue = 0.0;
      double remainingSize = (subject.remainingWork.length-1).toDouble();

      //Finds evenly spread out values between 0.0 and total available days.
      //startDate + the floor of each value is the date a workload is to be completed
      for(double i=0.0; i<=totalDays+0.001; i += totalDays/remainingSize){
        dateToStore = subject.startDate.add(new Duration(days: (i+skipValue).floor()));
        while(skipDates.contains(dateToStore)){
          skipValue += 1.0;
          dateToStore = subject.startDate.add(new Duration(days: (i+skipValue).floor()));
        }
        if(dateToStore.isAfter(subject.endDate)){
          while(skipDates.contains(dateToStore) || dateToStore.isAfter(subject.endDate)){
            dateToStore = subject.startDate.subtract(new Duration(days:1));
          }
        }
        
        calendar.putIfAbsent(dateToStore, () => Map<String, List<Workload>>());
        calendar[dateToStore].putIfAbsent(subject.name, () => List<Workload>());
        calendar[dateToStore][subject.name].add(subject.remainingWork[workPosition]);
        workPosition += 1;
      }
    }

    Map<DateTime, Map<String, List<Workload>>> sortedMap = SplayTreeMap.from(calendar);


//    PRETTY PRINT
//    for(DateTime date in calendar.keys){
//      int weight=0;
//      print(date);
//      for(String subj in calendar[date].keys){
//        print(subj);
//        for(Workload wl in calendar[date][subj]){
//          print(wl.workloadNo);
//          weight += 1;
//        }
//      }
//      print("Weight: " + weight.toString());
//      print("");
//    }
    return calendar;
  }

}
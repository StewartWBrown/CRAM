import 'dart:collection';

import 'package:flutter_app/database/databaseHelper.dart';
import 'package:flutter_app/main/futureArea.dart';
import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';

class Spread {
  spread(List<Subject> subjects, List<Workload> workloads, List<DateTime> skipDates) {

    //add exam dates to skipDates list
    for (int i = 0; i < subjects.length; i++) {
      if (!skipDates.contains(subjects[i].examDate)) {
        skipDates.add(DateTime.parse(subjects[i].examDate));
      }
    }

    //initially, spread workloads for subject between remaining study dates given
    Map<DateTime, Map<String, List<Workload>>> calendar = SplayTreeMap();
    int workPosition = 0;
    int initialWorkPos = 0;
    for (Subject subject in subjects) {
      DateTime startDate = DateTime.parse(subject.startDate);
      DateTime endDate = DateTime.parse(subject.endDate);

      //add in check to see if today's date is after start date here, if so make startDate today's date
      DateTime now = DateTime.now();
      if(startDate.isBefore(DateTime.now())){
        startDate = DateTime(now.year, now.month, now.day);
      }

      //if skip date within startDate and endDate, decrease studyTime (days) by 1 day
      int totalDays = endDate.difference(startDate).inDays;
      for (DateTime date in skipDates) {
        if (date.isAfter(startDate) && date.isBefore(endDate)) {
          totalDays -= 1;
        }
      }

      //evenly spread remaining workload between available days
      DateTime dateToStore;
      double skipValue = 0.0;
      double remainingWlNo = findRemainingWlNo(workloads, subject); //this integer should be calculated by using workloads database to find out which workloads have already been completed

      //Populate calendar with every day between start date and end date of subject EXCEPT SKIP DATES
      dateToStore = startDate;
      while((dateToStore.isBefore(endDate) || dateToStore == endDate)){
        if(!skipDates.contains(dateToStore)){
          calendar.putIfAbsent(dateToStore, () => Map<String, List<Workload>>());
        }
//        dateToStore = dateToStore.add(Duration(days: 1));
        dateToStore = DateTime(dateToStore.year, dateToStore.month, dateToStore.day+1);

      }

      //Finds evenly spread out values between 0.0 and total available days.
      //startDate + the floor of each value is the date a workload is to be completed
      for (double i = 0.0; (i <= totalDays + 0.001); i += totalDays / remainingWlNo) {
//        dateToStore = startDate.add(new Duration(days: (i + skipValue).floor()));
        dateToStore = DateTime(startDate.year, startDate.month, startDate.day+(i + skipValue).floor());
        while (skipDates.contains(dateToStore)) {
          skipValue += 1.0;
//          dateToStore = startDate.add(new Duration(days: (i + skipValue).floor()));
          dateToStore = DateTime(startDate.year, startDate.month, startDate.day+(i + skipValue).floor());

        }
        if (dateToStore.isAfter(endDate)) {
          while (skipDates.contains(dateToStore) || dateToStore.isAfter(endDate)) {
            dateToStore = DateTime(dateToStore.year, dateToStore.month, dateToStore.day-1);
          }
        }

        //find next available workload that is NOT completed and assign it to dateToStore.
        while(workloads[workPosition].complete==1){
          workPosition += 1;

          //prevent the loop from breaking
          if(workPosition>initialWorkPos+remainingWlNo){
            break;
          }
        }

        print("remaining wl no: " + remainingWlNo.toString());
        print("i: " + i.toString());
        print("work pos: " + workPosition.toString());
        print("max work pos: " + (initialWorkPos+remainingWlNo).toString());
        print("workload: " + workloads[workPosition].workloadName);
        print("date to store: " + dateToStore.toString());
        print("\n");

        workloads[workPosition].workloadDate = dateToStore.toString();

        //UPDATE DATE INTO WORKLOADS TABLE HERE
        updateWl(workloads[workPosition], DateTime.parse(workloads[workPosition].workloadDate));

        calendar.putIfAbsent(dateToStore, () => Map<String, List<Workload>>());
        calendar[dateToStore].putIfAbsent(subject.name, () => List<Workload>());
        calendar[dateToStore][subject.name].add(workloads[workPosition]);

        workPosition += 1;

        //prevent the loop from breaking
        if(workPosition>initialWorkPos+remainingWlNo){
          break;
        }
      }
      initialWorkPos = workPosition;
    }

//    //PRETTY PRINT FOR TESTING ------------------------------------------------------------------------
//    for (DateTime date in calendar.keys) {
//      int weight = 0;
//      print(date);
//      for (String subj in calendar[date].keys) {
//        for (Workload wl in calendar[date][subj]) {
//          print(subj + ": " + wl.workloadName + " - " + wl.workloadDate);
//          weight += wl.workloadDifficulty;
//        }
//      }
//      print("Weight: " + weight.toString());
//      print(
//          "_______________________________________________________________________");
//    }

    calendar = secondarySpread(calendar, subjects, workloads);
    calendar = secondarySpread(calendar, subjects, workloads);
    calendar = secondarySpread(calendar, subjects, workloads);
    calendar = secondarySpread(calendar, subjects, workloads);

    //Set date of complete workloads to NONE
    for(Workload wl in workloads){
      if(wl.complete == 1){
        updateWl(wl, null);
      }
    }
  }

  //secondary spreading - taking difficulty into account
  Map<DateTime, Map<String, List<Workload>>> secondarySpread(Map<DateTime, Map<String, List<Workload>>> calendar, List<Subject> subjects, List<Workload> workloads) {

    int prevDifficulty = 0;
    DateTime prevDate;
    for (DateTime date in calendar.keys) {
      int currentDifficulty = 0;
      for (String subject in calendar[date].keys) {
        for (Workload wl in calendar[date][subject]) {
          currentDifficulty += wl.workloadDifficulty;
        }
      }

      //if current date is weighted 2 or more in difficulty than previous date, use wlToMove method to decide which
      //workloads in the current date to move back to previous date
      if (currentDifficulty - prevDifficulty > 1 && prevDate != null) {
        Map<String, List<Workload>> wlToMove = findWlToMove(calendar[date], ((currentDifficulty - prevDifficulty) / 2).ceil(), prevDate, subjects);

//        //print test
//        for(String key in wlToMove.keys){
//          print(key + " moving back");
//          for(Workload wl in wlToMove[key]){
//            print(wl.workloadName);
//          }
//          print("_______________");
//        }

        for (String subj in wlToMove.keys) {
          for (Workload wl in wlToMove[subj]) {

            //UPDATE WORKLOAD DATABASE WITH DATE
            updateWl(wl, prevDate);

            //update workload date before adding to calendar
            wl.workloadDate = prevDate.toString();

            //update calendar
            calendar[prevDate].putIfAbsent(subj, () => List<Workload>());
            calendar[prevDate][subj].add(wl);
            calendar[date][subj].remove(wl);
            if (calendar[date][subj].isEmpty) {
              calendar[date].remove(subj);
            }
            prevDifficulty += wl.workloadDifficulty;
            currentDifficulty -= wl.workloadDifficulty;
          }
        }
      }

      //if previous date is weighted 2 or more in difficulty than current date, use wlToMove method to decide which
      //workloads in the previous date to move forward to current date
      if (prevDifficulty - currentDifficulty > 1) {
        Map<String, List<Workload>> wlToMove = findWlToMove(calendar[prevDate], ((prevDifficulty - currentDifficulty) / 2).ceil(), date, subjects);

//        //print test
//        for(String key in wlToMove.keys){
//          print(key + " moving forward");
//          for(Workload wl in wlToMove[key]){
//            print(wl.workloadName);
//          }
//          print("_______________");
//        }

        for (String subj in wlToMove.keys) {
          for (Workload wl in wlToMove[subj]) {
            //UPDATE DATE INTO WORKLOADS TABLE HERE
            updateWl(wl, date);

            //update workload date before adding to calendar
            wl.workloadDate = date.toString();

            //update calendar
            calendar[date].putIfAbsent(subj, () => List<Workload>());
            calendar[date][subj].add(wl);
            calendar[prevDate][subj].remove(wl);
            if (calendar[prevDate][subj].isEmpty) {
              calendar[prevDate].remove(subj);
            }
            currentDifficulty += wl.workloadDifficulty;
            prevDifficulty -= wl.workloadDifficulty;
          }
        }
      }
      prevDifficulty = currentDifficulty;
      prevDate = date;
    }
    return calendar;
  }

  //find workloads to be moved from one date to another
  Map<String, List<Workload>> findWlToMove(Map<String, List<Workload>> workload, int difficulty, DateTime currentDate, List<Subject> subjects) {
    Map<String, List<Workload>> wlToMove = Map();
    List<Workload> finalWl;
    int currentDifficultyTotal = 0;

    for (String subject in workload.keys) {
      //check if current subject being checked's endDate comes AFTER the date workloads are being moved to
      bool beforeEndAndAfterStart = false;
      for (Subject s in subjects) {
        DateTime startDate = DateTime.parse(s.startDate);
        DateTime endDate = DateTime.parse(s.endDate);

        //add in check to see if today's date is after start date here, if so make startDate today's date
        DateTime now = DateTime.now();
        if(startDate.isBefore(DateTime.now())){
          startDate = DateTime(now.year, now.month, now.day);
        }

        if (s.name == subject) {
          if ((endDate == currentDate || endDate.isAfter(currentDate)) && (startDate == currentDate || startDate.isBefore(currentDate))) {
            beforeEndAndAfterStart = true;
            break;
          }
        }
      }
      if (beforeEndAndAfterStart) {
        //find the correct workloads to move forward
        for (Workload wl in workload[subject]) {
          //if this workload is the exact difficulty weighting we're looking for, return that workload and we're done
          if (wl.workloadDifficulty == difficulty) {
            finalWl = [wl];
            wlToMove = Map();
            wlToMove[subject] = finalWl;
            return wlToMove;
          }
          else if (wl.workloadDifficulty < difficulty && currentDifficultyTotal < difficulty - wl.workloadDifficulty) {
            if (wlToMove.containsKey(subject)) {
              wlToMove[subject].add(wl);
            }
            else {finalWl = [wl];
              wlToMove[subject] = finalWl;
            }
            currentDifficultyTotal += wl.workloadDifficulty;
          }
        }
      }
    }
    return wlToMove;
  }

  //find remaining number of workloads yet to be completed
  double findRemainingWlNo(workloads, Subject subject){
    double i = 0.0;
    for(Workload wl in workloads){
      if(wl.complete == 0 && wl.subject == subject.name){
        i += 1.0;
      }
    }
    return i-1.0;
  }

  //UPDATE DATE INTO WORKLOADS TABLE HERE
  updateWl(Workload wl, DateTime date) {
    String newDate = "NONE";
    if(date != null){
      newDate = date.toString();
    }
    //update workloads database table
    var updatedWorkload = Workload(
      workloadID : wl.workloadID,
      subject : wl.subject,
      workloadName : wl.workloadName,
      workloadNumber : wl.workloadNumber,
      workloadDate : newDate,
      workloadDifficulty : wl.workloadDifficulty,
      complete : wl.complete,
    );
    DatabaseHelper.instance.updateWorkload(updatedWorkload);

    //update local workloads list
    for(Workload localWl in localWorkloads){
      if(localWl.workloadName == wl.workloadName){
        localWl.workloadDate = newDate;
        break;
      }
    }
  }
}

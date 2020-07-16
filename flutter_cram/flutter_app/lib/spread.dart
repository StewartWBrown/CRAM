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
    Map<DateTime, Map<String, List<Workload>>> calendar = SplayTreeMap();
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

    //secondary spreading - taking difficulty into account

    int prevDifficulty = 0;
    DateTime prevDate = null;
    for(DateTime date in calendar.keys){
      int currentDifficulty = 0;
      for(String subject in calendar[date].keys){
        for(Workload wl in calendar[date][subject]){
          currentDifficulty += wl.difficulty;
        }
      }

      //if current date is weighted 2 or more in difficulty than previous date, use wlToMove method to decide which
      //workloads in the current date to move back to previous date
      if(currentDifficulty-prevDifficulty>1 && prevDate!=null){
        Map<String, List<Workload>> wlToMove = findWlToMove(calendar[date], ((currentDifficulty-prevDifficulty)/2).floor(), prevDate, subjects);

        for(String subj in wlToMove.keys){
          for(Workload wl in wlToMove[subj]){
            calendar[prevDate].putIfAbsent(subj, () => List<Workload>());
            calendar[prevDate][subj].add(wl);
            calendar[date][subj].remove(wl);
            if(calendar[date][subj].isEmpty){
              calendar[date].remove(subj);
            }
            prevDifficulty += wl.difficulty;
            currentDifficulty -= wl.difficulty;
          }
        }
      }

      if(prevDifficulty-currentDifficulty>1){
        Map<String, List<Workload>> wlToMove = findWlToMove(calendar[prevDate], ((prevDifficulty-currentDifficulty)/2).floor(), date, subjects);

        for(String subj in wlToMove.keys){
          for(Workload wl in wlToMove[subj]){
            calendar[date].putIfAbsent(subj, () => List<Workload>());
            calendar[date][subj].add(wl);
            calendar[prevDate][subj].remove(wl);
            if(calendar[prevDate][subj].isEmpty){
              calendar[prevDate].remove(subj);
            }
            currentDifficulty += wl.difficulty;
            prevDifficulty -= wl.difficulty;
          }
        }
      }
      prevDifficulty = currentDifficulty;
      prevDate = date;
    }

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

  Map<String, List<Workload>> findWlToMove(Map<String, List<Workload>> workload, int difficulty, DateTime currentDate, List<Subject> subjects){
    Map<String, List<Workload>> wlToMove = Map();
    List<Workload> finalWl;
    int currentDifficultyTotal = 0;

    for(String subject in workload.keys){
      //check if current subject being checked's endDate comes AFTER the date workloads are being moved to
      bool beforeEndAndAfterStart = false;
      for(Subject s in subjects){
        if(s.name == subject){
          if((s.endDate == currentDate || s.endDate.isAfter(currentDate)) && (s.startDate == currentDate || s.startDate.isBefore(currentDate))){
            beforeEndAndAfterStart = true;
            break;
          }
        }
      }
      if(beforeEndAndAfterStart){
        //find the correct workloads to move forward
        for(Workload wl in workload[subject]){
          //if this workload is the exact difficulty weighting we're looking for, return that workload and we're done
          if(wl.difficulty == difficulty){
            finalWl = [wl];
            wlToMove = Map();
            wlToMove[subject] = finalWl;
            return wlToMove;
          } else if(wl.difficulty < difficulty && currentDifficultyTotal < difficulty - wl.difficulty){
            if(wlToMove.containsKey(subject)){
              wlToMove[subject].add(wl);
            } else{
              finalWl = [wl];
              wlToMove[subject] = finalWl;
            }
            currentDifficultyTotal += wl.difficulty;
          }
        }
      }
    }
    return wlToMove;
  }

}
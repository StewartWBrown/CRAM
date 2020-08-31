import 'dart:collection';

import 'package:flutter_app/model/subject.dart';
import 'package:flutter_app/model/workload.dart';
import 'mainScreen.dart';

class Spread {
  Map<DateTime, Map<String, List<Workload>>> spread(List<Subject> subjects, List<Workload> workloads, List<DateTime> skipDates) {

    //add exam dates to skipDates list
    for (int i = 0; i < subjects.length; i++) {
      if (!skipDates.contains(subjects[i].examDate)) {
        skipDates.add(DateTime.parse(subjects[i].examDate));
      }
    }

    //initially, spread workloads for subject between remaining study dates given
    Map<DateTime, Map<String, List<Workload>>> calendar = SplayTreeMap();
    int workPosition = 0;
    for (Subject subject in subjects) {
      DateTime startDate = DateTime.parse(subject.startDate);
      DateTime endDate = DateTime.parse(subject.endDate);

      // FEATURE_TO_ADD - add in check to see if todays date is after start date here, if so make startDate today's date

      int totalDays = endDate.difference(startDate).inDays;

      //if skip date within startDate and endDate, decrease studyTime (days) by 1 day
      for (DateTime date in skipDates) {
        if (date.isAfter(startDate) && date.isBefore(endDate)) {
          totalDays -= 1;
        }
      }

      //evenly spread remaining workload between available days
      DateTime dateToStore;
      double skipValue = 0.0;
      double remainingWlNo = (subject.workloads - 1).toDouble(); //FEATURE_TO_ADD - this integer should be calculated by using database to find out which workloads have already been completed

      //Finds evenly spread out values between 0.0 and total available days.
      //startDate + the floor of each value is the date a workload is to be completed
      for (double i = 0.0;
      i <= totalDays + 0.001;
      i += totalDays / remainingWlNo) {
        dateToStore = startDate.add(new Duration(days: (i + skipValue).floor()));
        while (skipDates.contains(dateToStore)) {
          skipValue += 1.0;
          dateToStore = startDate.add(new Duration(days: (i + skipValue).floor()));
        }
        if (dateToStore.isAfter(endDate)) {
          while (
          skipDates.contains(dateToStore) || dateToStore.isAfter(endDate)) {
            dateToStore = startDate.subtract(new Duration(days: 1));
          }
        }

        workloads[workPosition].workloadDate = dateToStore.toString();

        calendar.putIfAbsent(dateToStore, () => Map<String, List<Workload>>());
        calendar[dateToStore].putIfAbsent(subject.name, () => List<Workload>());
        calendar[dateToStore][subject.name].add(workloads[workPosition]);

        workPosition += 1;
      }
    }

    calendar = secondarySpread(calendar, subjects, workloads);
    calendar = secondarySpread(calendar, subjects, workloads);
    calendar = secondarySpread(calendar, subjects, workloads);

    //PRETTY PRINT FOR TESTING ------------------------------------------------------------------------
    for (DateTime date in calendar.keys) {
      int weight = 0;
      print(date);
      for (String subj in calendar[date].keys) {
        for (Workload wl in calendar[date][subj]) {
          print(subj + ": " + wl.workloadName);
          weight += wl.workloadDifficulty;
        }
      }
      print("Weight: " + weight.toString());
      print(
          "_______________________________________________________________________");
    }

    return calendar;
  }

  Map<DateTime, Map<String, List<Workload>>> secondarySpread(Map<DateTime, Map<String, List<Workload>>> calendar, List<Subject> subjects, List<Workload> workloads) {
    //secondary spreading - taking difficulty into account

    int prevDifficulty = 0;
    DateTime prevDate = null;
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
        Map<String, List<Workload>> wlToMove = findWlToMove(
            calendar[date],
            ((currentDifficulty - prevDifficulty) / 2).floor(),
            prevDate,
            subjects);

        for (String subj in wlToMove.keys) {
          for (Workload wl in wlToMove[subj]) {
            //update the dates in workloads list FEATURE_TO_ADD - this is only temp solution will be nicer with SQL
            for (Workload wl1 in workloads) {
              if (wl1.workloadID == wl.workloadID) {
                wl1.workloadDate = prevDate.toString();
              }
            }
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

      if (prevDifficulty - currentDifficulty > 1) {
        Map<String, List<Workload>> wlToMove = findWlToMove(calendar[prevDate], ((prevDifficulty - currentDifficulty) / 2).floor(), date, subjects);

        for (String subj in wlToMove.keys) {
          for (Workload wl in wlToMove[subj]) {
            //update the dates workloads list FEATURE_TO_ADD - this is only temp solution will be nicer with SQL
            for (Workload wl1 in workloads) {
              if (wl1.workloadID == wl.workloadID) {
                wl1.workloadDate = date.toString();
              }
            }
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
        if (s.name == subject) {
          if ((endDate == currentDate || endDate.isAfter(currentDate)) &&
              (s.startDate == currentDate || startDate.isBefore(currentDate))) {
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
          } else if (wl.workloadDifficulty < difficulty &&
              currentDifficultyTotal < difficulty - wl.workloadDifficulty) {
            if (wlToMove.containsKey(subject)) {
              wlToMove[subject].add(wl);
            } else {
              finalWl = [wl];
              wlToMove[subject] = finalWl;
            }
            currentDifficultyTotal += wl.workloadDifficulty;
          }
        }
      }
    }
    return wlToMove;
  }
}

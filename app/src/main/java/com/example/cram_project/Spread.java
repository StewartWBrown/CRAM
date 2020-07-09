package com.example.cram_project;

import android.annotation.TargetApi;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

public class Spread {
    
    //MAIN METHOD
    @TargetApi(24)
    public static Map<Date, HashMap<String, ArrayList<Workload>>> spread(ArrayList<Subject> subjects, ArrayList<Date> skip_dates) {

        //add exam dates to skip_dates list
        for(int i=0; i<subjects.size(); i++) {
            if(!skip_dates.contains(subjects.get(i).examDate)) {
                skip_dates.add(subjects.get(i).examDate);
            }
        }
        //spreading out workload process
        Map<Date, HashMap<String, ArrayList<Workload>>> calendar = new HashMap<>();
        for(Subject subject : subjects) {
            long total_days = TimeUnit.DAYS.convert((subject.endDate.getTime() - subject.startDate.getTime()), TimeUnit.MILLISECONDS);	//1 + (endDate - startDate)

            //if exam date within startDate & endDate, decrease study time (days) by 1 day
            for (Date date : skip_dates) {
                if(date.after(subject.startDate) && date.before(subject.endDate)) {
                    total_days -= 1;
                }
            }

            //evenly spread remaining workload between available days.
            int workPosition = 0;
            Date dateToStore;
            double skipValue = 0.0;
            double remainingSize = (double)subject.remainingWork.size()-1;

            //Finds evenly spread out values between 0.0 and total available days.
            //Start_date + the floor of each value is the date a workload is to be completed.
            for(double i=0.0; i<=total_days+0.0001; i += total_days/remainingSize) {
                dateToStore = incrementDateBy(subject.startDate, Math.floor(i)+skipValue);
                while(skip_dates.contains(dateToStore)) {       //if dateToBeAdded is to be skipped, go forward a day until you find free day
                    skipValue += 1.0;
                    dateToStore = incrementDateBy(subject.startDate, Math.floor(i)+skipValue);
                }
                if(dateToStore.after(subject.endDate)){         //if dateToBeAdded is AFTER end_date, go back a day until you find free day before end date
                    while(skip_dates.contains(dateToStore) || dateToStore.after(subject.endDate)){
                        dateToStore = decrementDateBy1(dateToStore);
                    }
                }

                calendar.putIfAbsent(dateToStore, new HashMap<String, ArrayList<Workload>>());
                calendar.get(dateToStore).putIfAbsent(subject.name, new ArrayList<Workload>());
                calendar.get(dateToStore).get(subject.name).add(subject.remainingWork.get(workPosition));
                workPosition += 1;
            }
        }

        //secondary spreading - taking difficulty weightings into account
        Map<Date, HashMap<String, ArrayList<Workload>>> sortedMap = new TreeMap<>(calendar);      //sorts dictionary into ascending order of dates

        int prevDifficulty = -99999;
        Date prevDate = null;
        for(Date date : sortedMap.keySet()) {
            int currentDifficulty = 0;
            for(String subject : sortedMap.get(date).keySet()) {
                for(Workload wl : sortedMap.get(date).get(subject)) {
                    currentDifficulty += wl.difficulty;
                }
            }
            //if previous date is weighted 2 or more in difficulty than current date, use wlToMove method to decide which workloads in the
            //previous date to move forward to the current date.
            if(prevDifficulty-currentDifficulty>1) {
                HashMap<String, ArrayList<Workload>> wlToMove = findWlToMove(sortedMap.get(prevDate), Math.floorDiv(prevDifficulty-currentDifficulty,2), date, subjects);

                for(String subj : wlToMove.keySet()) {
                    for(Workload wl : wlToMove.get(subj)) {
                        sortedMap.get(date).putIfAbsent(subj, new ArrayList<Workload>());
                        sortedMap.get(date).get(subj).add(wl);
                        sortedMap.get(prevDate).get(subj).remove(wl);
                        if(sortedMap.get(prevDate).get(subj).isEmpty()) {
                            sortedMap.get(prevDate).remove(subj);
                        }
                    }
                }
            }

            //if current date is weighted 2 or more in difficulty than previous date, use wlToMove method to decide which workloads in the
            //current date to move back to the previous date.
            else if(currentDifficulty-prevDifficulty>1 && prevDate != null) {
                HashMap<String, ArrayList<Workload>> wlToMove = findWlToMove(sortedMap.get(date), Math.floorDiv(currentDifficulty-prevDifficulty,2), prevDate, subjects);

                for (String subj : wlToMove.keySet()) {
                    for (Workload wl : wlToMove.get(subj)) {
                        sortedMap.get(prevDate).putIfAbsent(subj, new ArrayList<Workload>());
                        sortedMap.get(prevDate).get(subj).add(wl);
                        sortedMap.get(date).get(subj).remove(wl);
                        if (sortedMap.get(date).get(subj).isEmpty()) {
                            sortedMap.get(date).remove(subj);
                        }
                    }
                }
            }
            prevDifficulty = currentDifficulty;
            prevDate = date;
        }
        return sortedMap;
    }

    //helper method to increment a date by a number of days
    public static Date incrementDateBy(Date currentDate, double dta) {
        Calendar c = Calendar.getInstance();
        c.setTime(currentDate);
        c.add(Calendar.DATE, (int)dta);
        return c.getTime();
    }

    public static Date decrementDateBy1(Date currentDate){
        Calendar cal = Calendar.getInstance();
        cal.setTime (currentDate); // convert your date to Calendar object
        cal.add(Calendar.DATE, -1);
        return cal.getTime(); // again get back your date object
    }

    //NEXT STEP IS TO CREATE A REVERSE OF THIS METHOD!!!!!!!!!!!!!!!!!!!!!
    //helper method to find out which workloads to move from previous date to current date for equal spreading purposes.
    public static HashMap<String, ArrayList<Workload>> findWlToMove(HashMap<String, ArrayList<Workload>> workload, Integer difficulty, Date currentDate, ArrayList<Subject> subjects) {
        HashMap<String, ArrayList<Workload>> wlToMove = new HashMap<>();
        ArrayList<Workload> finalWl;
        Integer currentDifficultyTotal = 0;

        for(String subject : workload.keySet()) {
            //check if current subject being checked's end date comes AFTER the date workloads are being moved to
            boolean beforeEndAndAfterStart = false;
            for(Subject s : subjects){
                if (s.name == subject){
                    if((s.endDate == currentDate || s.endDate.after(currentDate)) && (s.startDate == currentDate || s.startDate.before(currentDate))){
                        beforeEndAndAfterStart = true;
                        break;
                    }
                }
            }
            if(beforeEndAndAfterStart) {
                //find the correct workloads to move forward
                for (Workload wl : workload.get(subject)) {
                    //if this workload is the exact difficulty weighting we're looking for, return that workload and we're done
                    if (wl.difficulty == difficulty) {
                        finalWl = new ArrayList<>(Arrays.asList(wl));
                        wlToMove = new HashMap<>();
                        wlToMove.put(subject, finalWl);
                        return wlToMove;
                    //if this workload is less than the difficulty we're looking for AND less than current found difficulty weighting -> add to workloads to be added list
                    } else if (wl.difficulty < difficulty && currentDifficultyTotal < difficulty - wl.difficulty) {
                        if (wlToMove.containsKey(subject)) {
                            wlToMove.get(subject).add(wl);
                        } else {
                            finalWl = new ArrayList<>(Arrays.asList(wl));
                            wlToMove.put(subject, finalWl);
                        }
                        currentDifficultyTotal += wl.difficulty;
                    }
                }
            }
        }
        return wlToMove;
    }
}
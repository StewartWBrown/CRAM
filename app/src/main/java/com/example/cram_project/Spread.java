package com.example.cram_project;

import android.annotation.TargetApi;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

public class Spread {

	/*
	______________________________________________________________________________________________________________
	|NEXT ISSUE:																								  |
	|	- ENSURE THAT WHEN MOVING WORKLOADS FORWARD A DATE, THE WORKLOAD ISN'T SURPASSING IT'S SUBJECT'S END DATE |
	|_____________________________________________________________________________________________________________|
	*/


    //MAIN METHOD
    @TargetApi(24)
    public static Map<Date, HashMap<String, ArrayList<Integer>>> spread(ArrayList<Subject> subjects) {

        ArrayList<Date> skip_dates = new ArrayList<Date>();

        //add exam dates to skip_dates list
        for(int i=0; i<subjects.size(); i++) {
            if(!skip_dates.contains(subjects.get(i).examDate)) {
                skip_dates.add(subjects.get(i).examDate);
            }
        }

        //spreading out workload process
        Map<Date, HashMap<String, ArrayList<Integer>>> calendar = new HashMap<>();
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
            Date dateToStore = subject.startDate;
            double skipValue = 0.0;
            double remainingSize = (double)subject.remainingWork.size()-1;

            for(double i=0.0; i<=total_days+0.0001; i += total_days/remainingSize) {
                dateToStore = incrementDateBy(subject.startDate, Math.floor(i)+skipValue);
                if(skip_dates.contains(dateToStore)) {
                    skipValue += 1.0;
                    dateToStore = incrementDateBy(subject.startDate, Math.floor(i)+skipValue);
                }
                calendar.putIfAbsent(dateToStore, new HashMap<String, ArrayList<Integer>>());
                calendar.get(dateToStore).putIfAbsent(subject.name, new ArrayList<Integer>());
                calendar.get(dateToStore).get(subject.name).add(subject.remainingWork.get(workPosition));
                workPosition += 1;
            }
        }

        //if previous date contains 2 or more workloads than current day, take away 1 workload from previous and add to current
        Map<Date, HashMap<String, ArrayList<Integer>>> sortedMap = new TreeMap<>(calendar);

        int previous = -99999;
        Date prevDate = null;
        for(Date date : sortedMap.keySet()) {
            int current = 0;
            for(String subject : sortedMap.get(date).keySet()) {
                current += sortedMap.get(date).get(subject).size();
            }

            if(previous-current>1) {
                String subjToChange = (String) (sortedMap.get(prevDate).keySet().toArray()[sortedMap.get(prevDate).keySet().toArray().length-1]);
                Integer workloadToChange = (Integer) sortedMap.get(prevDate).get(subjToChange).toArray()[sortedMap.get(prevDate).get(subjToChange).toArray().length-1];

                sortedMap.get(date).putIfAbsent(subjToChange, new ArrayList<Integer>());
                sortedMap.get(date).get(subjToChange).add(workloadToChange);
                sortedMap.get(prevDate).get(subjToChange).remove(workloadToChange);

                if(sortedMap.get(prevDate).get(subjToChange).isEmpty()) {
                    sortedMap.get(prevDate).remove(subjToChange);
                }
            }
            previous = current;
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

}
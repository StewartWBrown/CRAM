package cram_project;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

public class Main {
	
	//MAIN METHOD 
	public static void main(String[] args) {
		
		ArrayList<Subject> subjects = new ArrayList<Subject>();
		ArrayList<Date> skip_dates = new ArrayList<Date>();
		
		Subject CSF = new Subject(
				"CSF",
				27, 
				new ArrayList<Integer>(Arrays.asList(1, 2, 3)),
				new GregorianCalendar(2021, Calendar.MAY, 1).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 22).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 23).getTime()
				);
		Subject MHCI = new Subject(
				"MHCI",
				11, 
				new ArrayList<Integer>(Arrays.asList(1, 2)),
				new GregorianCalendar(2021, Calendar.MAY, 1).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 20).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 21).getTime()
				);
		Subject PSD = new Subject(
				"PSD",
				12, 
				new ArrayList<Integer>(Arrays.asList(1)),
				new GregorianCalendar(2021, Calendar.MAY, 4).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 25).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 27).getTime()
				);
		
		subjects.add(CSF);
		subjects.add(MHCI);
		subjects.add(PSD);
		
		//add exam dates to skip_dates list
		for(int i=0; i<subjects.size(); i++) {
			if(!skip_dates.contains(subjects.get(i).examDate)) {
				skip_dates.add(subjects.get(i).examDate);
			}
		}
		
		Map<Date, HashMap<String, ArrayList<Integer>>> calendar = new HashMap<Date, HashMap<String, ArrayList<Integer>>>();
		//spreading out workload process
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
				calendar.putIfAbsent(dateToStore, new HashMap<>());
				calendar.get(dateToStore).putIfAbsent(subject.name, new ArrayList<>());
				calendar.get(dateToStore).get(subject.name).add(subject.remainingWork.get(workPosition));
				workPosition += 1;
			}	
			
		}
		
		//print the results for testing purposes
		Map<Date, HashMap<String, ArrayList<Integer>>> sortedMap = new TreeMap<Date, HashMap<String, ArrayList<Integer>>>(calendar);
		for(Date key : sortedMap.keySet()) {
			System.out.println(key + " " + calendar.get(key));
		}
		
	}
	
	//helper method to increment a date by a number of days
	public static Date incrementDateBy(Date currentDate, double dta) {
		Calendar c = Calendar.getInstance(); 
		c.setTime(currentDate); 
		c.add(Calendar.DATE, (int)dta);
		return c.getTime();
	}
	
}

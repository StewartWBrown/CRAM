package cram_project;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.concurrent.TimeUnit;

public class Main {
	
	//MAIN METHOD 
	public static void main(String[] args) {
		
		ArrayList<Subject> subjects = new ArrayList<Subject>();
		ArrayList<Date> skip_dates = new ArrayList<Date>();
		
		Subject CSF = new Subject(
				18, 
				new ArrayList<Integer>(Arrays.asList(1, 2, 3)),
				new GregorianCalendar(2021, Calendar.MAY, 1).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 22).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 23).getTime()
				);
		Subject MHCI = new Subject(
				11, 
				new ArrayList<Integer>(Arrays.asList(1, 2)),
				new GregorianCalendar(2021, Calendar.MAY, 1).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 20).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 21).getTime()
				);
		Subject PSD = new Subject(
				12, 
				new ArrayList<Integer>(Arrays.asList(1)),
				new GregorianCalendar(2021, Calendar.MAY, 4).getTime(), 
				new GregorianCalendar(2021, Calendar.MAY, 26).getTime(), 
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
		
		for(Subject subject : subjects) {
			long total_days = 1 + TimeUnit.DAYS.convert((subject.endDate.getTime() - subject.startDate.getTime()), TimeUnit.MILLISECONDS);	//1 + (endDate - startDate)
			
			//if exam date within startDate & endDate, decrease study time by 1 day
			for (Date date : skip_dates) {
				if(date.after(subject.startDate) && date.before(subject.endDate)) {
					total_days -= 1;
				}
			}
			
			//evenly spread remaining workload between available days.
			
			
			
		}
		

		
		
		
	}
	
}

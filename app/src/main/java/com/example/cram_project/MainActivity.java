package com.example.cram_project;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    EditText subjectNameInput;
    EditText noOfWorkloadsInput;
    EditText wlCompletedInput;
    EditText difficultyInput;

    private TextView mStartDisplayDate;
    private DatePickerDialog.OnDateSetListener mStartDateSetListener;

    private TextView mEndDisplayDate;
    private DatePickerDialog.OnDateSetListener mEndDateSetListener;

    private TextView mExamDisplayDate;
    private DatePickerDialog.OnDateSetListener mExamDateSetListener;

    String subjectName;
    Integer noOfWorkloads;
    String[] wlCompleted;
    Integer difficulty;
    SimpleDateFormat df;
    Date startDate;
    Date endDate;
    Date examDate;
    ArrayList<Subject> subjects = new ArrayList<>();
    Subject subj;
    Map<Date, HashMap<String, ArrayList<Workload>>> calendar;
    String outputText;

    Date earliestDate = new Date(Long.MAX_VALUE);
    Date latestDate = new Date(Long.MIN_VALUE);
    ArrayList<Date> skipDates;

    static boolean monday;
    static boolean tuesday;
    static boolean wednesday;
    static boolean thursday;
    static boolean friday;
    static boolean saturday;
    static boolean sunday;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        df = new SimpleDateFormat("dd/MM/yyyy", Locale.UK);
        subjectNameInput = findViewById(R.id.subjectNameID);
        noOfWorkloadsInput = findViewById(R.id.noOfWorkloadsID);
        wlCompletedInput = findViewById(R.id.workloadsCompletedID);
        difficultyInput = findViewById(R.id.wlDifficultyID);
        Button daysOffButton = findViewById(R.id.daysOffID);
        Button submitButton = findViewById(R.id.enterSubjectID);
        Button doneButton = findViewById(R.id.doneButtonID);

        // Dates chosen to display
        mStartDisplayDate = findViewById(R.id.startDateID);
        mEndDisplayDate = findViewById(R.id.endDateID);
        mExamDisplayDate = findViewById(R.id.examDateID);

        //TEST SUBJECTS TO BE REMOVED IN FINAL BUILDDDDDD
        Subject CSF = new Subject(
                "CSF",
                27,
                new ArrayList<>(Arrays.asList(1, 2, 3)),
                1,
                toDate(1 + "/" + 5 + "/" + 2021),
                toDate(22 + "/" + 5 + "/" + 2021),
                toDate(23 + "/" + 5 + "/" + 2021)
        );
        Subject MHCI = new Subject(
                "MHCI",
                11,
                new ArrayList<>(Arrays.asList(1, 2)),
                2,
                toDate(1 + "/" + 5 + "/" + 2021),
                toDate(20 + "/" + 5 + "/" + 2021),
                toDate(21 + "/" + 5 + "/" + 2021)
        );
        Subject PSD = new Subject(
                "PSD",
                12,
                new ArrayList<>(Arrays.asList(1)),
                3,
                toDate(4 + "/" + 5 + "/" + 2021),
                toDate(26 + "/" + 5 + "/" + 2021),
                toDate(27 + "/" + 5 + "/" + 2021)
        );

        subjects.add(CSF);
        subjects.add(MHCI);
        subjects.add(PSD);

        earliestDate = toDate(1 + "/" + 5 + "/" + 2021);
        latestDate = toDate(26 + "/" + 5 + "/" + 2021);


        // Enter start date
        mStartDisplayDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Calendar startCal = Calendar.getInstance();
                int startYear = startCal.get(Calendar.YEAR);
                int startMonth = startCal.get(Calendar.MONTH);
                int startDay = startCal.get(Calendar.DAY_OF_MONTH);

                // Change the date picker style below to change the appearance of the picker
                DatePickerDialog dialog = new DatePickerDialog(
                        MainActivity.this,
                        android.R.style.Theme_Holo_Light_Dialog_MinWidth,
                        mStartDateSetListener,
                        startYear, startMonth, startDay);
                dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                dialog.show();
            }
        });

        // change to show date entered on display
        mStartDateSetListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                month = month + 1;

                String date = dayOfMonth + "/" + month + "/" + year;
                mStartDisplayDate.setText(date);
                startDate = toDate(date);

                if(startDate.before(earliestDate)){
                    earliestDate = startDate;
                }
            }
        };

        // Enter End date
        mEndDisplayDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Calendar startCal = Calendar.getInstance();
                int startYear = startCal.get(Calendar.YEAR);
                int startMonth = startCal.get(Calendar.MONTH);
                int startDay = startCal.get(Calendar.DAY_OF_MONTH);

                // Change the date picker style below to change the appearance of the picker
                DatePickerDialog dialog = new DatePickerDialog(
                        MainActivity.this,
                        android.R.style.Theme_Holo_Light_Dialog_MinWidth,
                        mEndDateSetListener,
                        startYear, startMonth, startDay);
                dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                dialog.show();
            }
        });

        // change to show date entered on display
        mEndDateSetListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                month = month + 1;

                String date = dayOfMonth + "/" + month + "/" + year;
                mEndDisplayDate.setText(date);
                endDate = toDate(date);

                if(endDate.after(latestDate)){
                    latestDate = endDate;
                }
            }
        };

        // Enter Exam date
        mExamDisplayDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Calendar startCal = Calendar.getInstance();
                int startYear = startCal.get(Calendar.YEAR);
                int startMonth = startCal.get(Calendar.MONTH);
                int startDay = startCal.get(Calendar.DAY_OF_MONTH);

                // Change the date picker style below to change the appearance of the picker
                DatePickerDialog dialog = new DatePickerDialog(
                        MainActivity.this,
                        android.R.style.Theme_Holo_Light_Dialog_MinWidth,
                        mExamDateSetListener,
                        startYear, startMonth, startDay);
                dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                dialog.show();
            }
        });

        // change to show date entered on display
        mExamDateSetListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                month = month + 1;

                String date = dayOfMonth + "/" + month + "/" + year;
                mExamDisplayDate.setText(date);
                examDate = toDate(date);
            }
        };

        // days off button
        daysOffButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this, DaysOff.class));
            }
        });



        // submit subject button
        submitButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                wlCompleted = wlCompletedInput.getText().toString().split(",");
                ArrayList<Integer> wlc = new ArrayList<>();
                if(wlCompleted.length>1) {
                    for (String s : wlCompleted) {
                        wlc.add(Integer.parseInt(s.trim()));
                    }
                }

                if(subjectNameInput.length()==0) {
                    subjectNameInput.requestFocus();
                    subjectNameInput.setError("FIELD CANNOT BE EMPTY");
                } else{subjectName = subjectNameInput.getText().toString();}

                if(noOfWorkloadsInput.length()==0) {
                    noOfWorkloadsInput.requestFocus();
                    noOfWorkloadsInput.setError("FIELD CANNOT BE EMPTY");
                } else{noOfWorkloads = Integer.parseInt(noOfWorkloadsInput.getText().toString());}

                if(difficultyInput.length()==0) {
                    difficultyInput.requestFocus();
                    difficultyInput.setError("FIELD CANNOT BE EMPTY");
                }
                else{
                    difficulty = Integer.parseInt(difficultyInput.getText().toString());
                    if(difficulty<1 || difficulty>3){
                        difficultyInput.requestFocus();
                        difficultyInput.setError("DIFFICULTY MUST BE BETWEEN 1 AND 3");
                    }
                }

                if(startDate == null){
                    mStartDisplayDate.requestFocus();
                    mStartDisplayDate.setError("CHOOSE A START DATE");
                }
                if(endDate == null){
                    mEndDisplayDate.requestFocus();
                    mEndDisplayDate.setError("CHOOSE AN END DATE");
                }
                if(examDate == null){
                    mExamDisplayDate.requestFocus();
                    mExamDisplayDate.setError("CHOOSE AN EXAM DATE");
                }
                else{
                    subj = new Subject(subjectName, noOfWorkloads, wlc, difficulty, startDate, endDate, examDate);
                    subjects.add(subj);

                    subjectNameInput.setText("");
                    noOfWorkloadsInput.setText("");
                    wlCompletedInput.setText("");
                    difficultyInput.setText("");
                    mStartDisplayDate.setText("");
                    mEndDisplayDate.setText("");
                    mExamDisplayDate.setText("");
                }
            }
        });

        // done button
        doneButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                ArrayList<String> daysToSkip = new ArrayList<>();

                if(monday){
                    daysToSkip.add("Monday");
                }
                if(tuesday){
                    daysToSkip.add("Tuesday");
                }
                if(wednesday){
                    daysToSkip.add("Wednesday");
                }
                if(thursday){
                    daysToSkip.add("Thursday");
                }
                if(friday){
                    daysToSkip.add("Friday");
                }
                if(saturday){
                    daysToSkip.add("Saturday");
                }
                if(sunday){
                    daysToSkip.add("Sunday");
                }

                skipDates = daysBetweenDates(earliestDate, Spread.incrementDateBy(latestDate, 1), daysToSkip);
                calendar = Spread.spread(subjects, skipDates);
                outputText = translateToString(calendar);
                Intent doneOutput = new Intent(MainActivity.this, workloadOutput.class);
                doneOutput.putExtra("planner", outputText);
                startActivity(doneOutput);
            }
        });
    }
    // Helper method to turn string into a date
    public static Date toDate(String textDate){
       SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy", Locale.UK);
       try {
           Date desiredDate = df.parse(textDate);
           Calendar calender = Calendar.getInstance();
           calender.setTime(desiredDate);
           return calender.getTime();
       }
       catch (ParseException e) {
           System.out.println("Invalid date format");
       }
       return null;
    }

    //find days between dates that are to be skipped
    public static ArrayList<Date> daysBetweenDates(Date start, Date end, ArrayList<String> daysToSkip)
    {
        ArrayList<Date> dates = new ArrayList<>();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(start);
        SimpleDateFormat simpleDateformat = new SimpleDateFormat("EEEE", Locale.UK);

        while (calendar.getTime().before(end))
        {
            Date result = calendar.getTime();
            String day = simpleDateformat.format(result);

            if(daysToSkip.contains(day)){
                dates.add(result);
            }
            calendar.add(Calendar.DATE, 1);
        }
        return dates;
    }

    // The data structure is of format Map<date, hashmap<String, List<Object>>>
    public String translateToString(Map planner){
        if (planner.isEmpty()){
            return "No subjects or workloads have been entered, \n";
        }
        int counter = 1;
        StringBuilder sb = new StringBuilder();
        // loop through map

        //print the results for testing purposes
        int weight;
        for(Date date : calendar.keySet()) {
            weight = 0;
            sb.append(date + "\n");
            for(String subject : calendar.get(date).keySet()) {
                for(Workload wl : calendar.get(date).get(subject)) {
                    sb.append("Subject: " + subject + "--- Workload: " + wl.workloadNo + "\n");
                    weight += wl.difficulty;
                }
            }
            sb.append("Weight: " + weight + "\n\n");
        }
        return sb.toString();
    }

}


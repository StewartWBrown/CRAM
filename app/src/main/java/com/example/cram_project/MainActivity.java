package com.example.cram_project;

import android.app.DatePickerDialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    EditText subjectNameInput;
    EditText noOfWorkloadsInput;
    EditText wlCompletedInput;

    private TextView mStartDisplayDate;
    private DatePickerDialog.OnDateSetListener mStartDateSetListener;

    private TextView mEndDisplayDate;
    private DatePickerDialog.OnDateSetListener mEndDateSetListener;

    private TextView mExamDisplayDate;
    private DatePickerDialog.OnDateSetListener mExamDateSetListener;

    String subjectName;
    Integer noOfWorkloads;
    String[] wlCompleted;
    SimpleDateFormat df;
    Date startDate;
    Date endDate;
    Date examDate;
    ArrayList<Subject> subjects = new ArrayList<>();
    Subject subj;
    Map<Date, HashMap<String, ArrayList<Workload>>> calendar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        df = new SimpleDateFormat("dd/MM/yyyy", Locale.UK);
        subjectNameInput = findViewById(R.id.subjectNameID);
        noOfWorkloadsInput = findViewById(R.id.noOfWorkloadsID);
        wlCompletedInput = findViewById(R.id.workloadsCompletedID);
        Button submitButton = findViewById(R.id.enterSubjectID);

        // Dates chosen to display
        mStartDisplayDate = findViewById(R.id.startDate);
        mEndDisplayDate = findViewById(R.id.endDate);
        mExamDisplayDate = findViewById(R.id.examDate);


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


        submitButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                subjectName = subjectNameInput.getText().toString();
                noOfWorkloads = Integer.parseInt(noOfWorkloadsInput.getText().toString());

                wlCompleted = wlCompletedInput.getText().toString().split(",");
                ArrayList<Integer> wlc = new ArrayList<>();
                for(String s : wlCompleted){
                    wlc.add(Integer.parseInt(s.trim()));
                }

                subj = new Subject(subjectName, noOfWorkloads, wlc, startDate, endDate, examDate);
                subjects.add(subj);

                subjectNameInput.setText("");
                noOfWorkloadsInput.setText("");
                wlCompletedInput.setText("");
                mStartDisplayDate.setText("");
                mEndDisplayDate.setText("");
                mExamDisplayDate.setText("");

            }
        });

        Button doneButton = findViewById(R.id.doneButtonID);
        doneButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                calendar = Spread.spread(subjects);
                Log.i("Calender: ", calendar.keySet().toString());
                Log.i("Subjects on date", calendar.values().toString());
            }
        });


    }
    // Helper method to turn string into a date
    public static Date toDate(String textDate){
       SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
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
    }


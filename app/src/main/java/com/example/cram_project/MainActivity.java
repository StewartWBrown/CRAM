package com.example.cram_project;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    EditText subjectNameInput;
    EditText noOfWorkloadsInput;
    EditText wlCompletedInput;
    EditText startDateInput;
    EditText endDateInput;
    EditText examDateInput;

    String subjectName;
    Integer noOfWorkloads;
    String[] wlCompleted;
    SimpleDateFormat df;
    Date startDate;
    Date endDate;
    Date examDate;
    ArrayList<Subject> subjects = new ArrayList<>();
    Subject subj;
    Map<Date, HashMap<String, ArrayList<Integer>>> calendar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        df = new SimpleDateFormat("dd/MM/yyyy", Locale.UK);
        subjectNameInput = findViewById(R.id.subjectNameID);
        noOfWorkloadsInput = findViewById(R.id.noOfWorkloadsID);
        wlCompletedInput = findViewById(R.id.workloadsCompletedID);
        startDateInput = findViewById(R.id.startDateID);
        endDateInput = findViewById(R.id.endDateID);
        examDateInput = findViewById(R.id.examDateID);

        Button submitButton = findViewById(R.id.enterSubjectID);
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

                try{
                    startDate = df.parse(startDateInput.getText().toString());
                } catch(ParseException e){
                    e.printStackTrace();
                }

                try{
                    endDate = df.parse(endDateInput.getText().toString());
                } catch(ParseException e){
                    e.printStackTrace();
                }

                try{
                    examDate = df.parse(examDateInput.getText().toString());
                } catch(ParseException e){
                    e.printStackTrace();
                }

                subj = new Subject(subjectName, noOfWorkloads, wlc, startDate, endDate, examDate);
                subjects.add(subj);

                subjectNameInput.setText("");
                noOfWorkloadsInput.setText("");
                wlCompletedInput.setText("");
                startDateInput.setText("");
                endDateInput.setText("");
                examDateInput.setText("");
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

}

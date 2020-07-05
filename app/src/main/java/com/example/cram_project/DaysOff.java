package com.example.cram_project;

import android.app.Activity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.widget.CompoundButton;
import android.widget.Switch;

import androidx.annotation.Nullable;

public class DaysOff extends Activity {

    Switch mondayInput;
    Switch tuesdayInput;
    Switch wednesdayInput;
    Switch thursdayInput;
    Switch fridayInput;
    Switch saturdayInput;
    Switch sundayInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.days_off);
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        int width = dm.widthPixels;
        int height = dm.heightPixels;
        getWindow().setLayout((int)(width*0.5),(int)(height*0.5));

        // monday
        mondayInput = findViewById(R.id.mondayID);
        mondayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.monday = true;
                }
                else{
                    MainActivity.monday=false;
                }
            }
        });

        // tuesday
        tuesdayInput = findViewById(R.id.tuesdayID);
        tuesdayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.tuesday = true;
                }
                else{
                    MainActivity.tuesday=false;
                }
            }
        });

        // wednesday
        wednesdayInput = findViewById(R.id.wednesdayID);
        wednesdayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.wednesday = true;
                }
                else{
                    MainActivity.wednesday=false;
                }
            }
        });

        // thursday
        thursdayInput = findViewById(R.id.thursdayID);
        thursdayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.thursday = true;
                }
                else{
                    MainActivity.thursday=false;
                }
            }
        });

        // friday
        fridayInput = findViewById(R.id.fridayID);
        fridayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.friday = true;
                }
                else{
                    MainActivity.friday=false;
                }
            }
        });

        // saturday
        saturdayInput = findViewById(R.id.saturdayID);
        saturdayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.saturday = true;
                }
                else{
                    MainActivity.saturday=false;
                }
            }
        });

        // sunday
        sundayInput = findViewById(R.id.sundayID);
        sundayInput.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

                if(isChecked==true){
                    MainActivity.sunday = true;
                }
                else{
                    MainActivity.sunday=false;
                }
            }
        });







    }
}

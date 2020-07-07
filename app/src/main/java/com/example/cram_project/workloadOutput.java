package com.example.cram_project;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.text.method.ScrollingMovementMethod;

public class workloadOutput extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_workload_output);
        Button backButton = findViewById(R.id.returnID);
        backButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        String outputText = getIntent().getStringExtra("planner");

        TextView textView = findViewById(R.id.printedTimetableID);
        textView.setText(outputText);
        textView.setMovementMethod(new ScrollingMovementMethod());

    }


}

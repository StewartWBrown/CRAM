package com.example.cram_project;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        int myValue = 5;
        String message = "The value is " + myValue;
        TextView tv = findViewById(R.id.my_text_view);
        tv.setText(message);
    }

}

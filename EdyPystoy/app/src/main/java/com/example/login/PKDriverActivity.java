package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.format.DateUtils;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Calendar;

public class PKDriverActivity extends AppCompatActivity {

    Button button2;
    private TextView p_data;
    private EditText p_pktA,p_pktB;
    Calendar dateAndTime=Calendar.getInstance();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pkdriver);

        p_pktA = findViewById(R.id.p_pktA);
        p_pktB = findViewById(R.id.p_pnktB);
        button2 = findViewById(R.id.button2);

        button2.setOnClickListener(
                v -> {
                    if (p_pktA.getText().toString().equals("")) {
                        Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
                    } else if (p_pktB.getText().toString().equals("")) {
                        Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
                    } else {
                        Intent intent = new Intent(PKDriverActivity.this, BDdriver.class);
                        intent.putExtra("pkt", p_pktA.getText().toString());
                        intent.putExtra("pktB", p_pktB.getText().toString());
                        startActivity(intent);
                    }


    });
    }


}

package com.example.login;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class OpenProfil extends AppCompatActivity {

    TextView ttid;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.openprofil);

        ttid = findViewById(R.id.nomtel);


        String txtName = getIntent().getStringExtra("ttid");
        ttid.setText(ttid.getText().toString() + " " + txtName);

    }
}

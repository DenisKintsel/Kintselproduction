package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class PKGryzActivity extends AppCompatActivity {

    Button btnN;
    private EditText gryzA,g_pktB;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pkgryz);

        gryzA = findViewById(R.id.gryzA);
        g_pktB = findViewById(R.id.gryzB);
        btnN = findViewById(R.id.naiti);
        btnN.setOnClickListener(
                v -> {
                    if (gryzA.getText().toString().equals("")) {
                        Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
                    } else if (g_pktB.getText().toString().equals("")) {
                        Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
                    } else {
                        Intent intent = new Intent(PKGryzActivity.this, PoiskActivity.class);
                        intent.putExtra("pkt", gryzA.getText().toString());
                        intent.putExtra("pktB", g_pktB.getText().toString());
                        startActivity(intent);
                    }

                });
    }
}

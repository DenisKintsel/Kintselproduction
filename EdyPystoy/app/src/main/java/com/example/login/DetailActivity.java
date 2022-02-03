package com.example.login;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class DetailActivity extends AppCompatActivity {

    TextView ttid, idname, pynktA, pynktB, tvgryz, g_price, tvphone;
    Button vzv;
    Button openprofil;
    String number;
    int position;

    //@RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        ttid = findViewById(R.id.g_id);
        idname = findViewById(R.id.g_idname);
        pynktA = findViewById(R.id.g_pynktA);
        pynktB = findViewById(R.id.g_pynktB);
        tvgryz = findViewById(R.id.g_gryz);
        g_price = findViewById(R.id.g_price);
        tvphone = findViewById(R.id.g_phone);
        vzv = findViewById(R.id.vzv);
        openprofil=findViewById(R.id.openprofil);


        Intent intent =getIntent();
        position = intent.getExtras().getInt("position");


        ttid.setText("Номер объявления: " + PoiskActivity.employeeArrayList.get(position).getIdgryz());
        idname.setText("Имя: " + PoiskActivity.employeeArrayList.get(position).getIdname());
        pynktA.setText("Город отправки: " + PoiskActivity.employeeArrayList.get(position).getPynktA());
        pynktB.setText("Город прибытия: " + PoiskActivity.employeeArrayList.get(position).getPynktB());
        tvgryz.setText("Вид Груза: " + PoiskActivity.employeeArrayList.get(position).getVid());
        g_price.setText("Готов Заплатить: " + PoiskActivity.employeeArrayList.get(position).getPrice());
        tvphone.setText(PoiskActivity.employeeArrayList.get(position).getPhone());


        String phoneNo = tvphone.getText().toString();

        vzv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent in = new Intent(Intent.ACTION_VIEW, Uri.parse(String.format("tel:%s", phoneNo)));
                startActivity(in);
            }
        });

        openprofil.setOnClickListener(
                v -> {
                    Intent iee = new Intent(DetailActivity.this, OpenProfil.class);
               //     iee.putExtra("ID",ttid.getText().toString());
                    iee.putExtra("ttid",ttid.getText().toString());
                    startActivity(iee);

                });




    }
}

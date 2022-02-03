package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class Detail3Activity extends AppCompatActivity {


    private TextView idusers, nameuser,passworduser;
    int position;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail3);

        idusers = findViewById(R.id.iduser);
        nameuser = findViewById(R.id.txtname1);
        passworduser = findViewById(R.id.txtpassword);

        Intent intent =getIntent();
        position = intent.getExtras().getInt("position");

        idusers.setText("Id: "+ProfilActivity.employeeArrayList.get(position).getIduser());
        nameuser.setText("Имя: "+ProfilActivity.employeeArrayList.get(position).getName());
        passworduser.setText("Пароль: "+ProfilActivity.employeeArrayList.get(position).getPassword());
    }
}

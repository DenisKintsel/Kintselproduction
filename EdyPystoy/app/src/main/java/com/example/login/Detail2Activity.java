package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class Detail2Activity extends AppCompatActivity {

    TextView id_name, tvid,tvpynktA,tvpynktB,tvavto,tvphone,tvdata;
    Button vzv;
    int position;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail2);

        tvid = findViewById(R.id.txtid);
        id_name = findViewById(R.id.txtidname);
        tvpynktA = findViewById(R.id.txtpynktA);
        tvpynktB = findViewById(R.id.txtpynktB);
        tvavto = findViewById(R.id.txtavto);
        tvphone = findViewById(R.id.txtphone);
        tvdata = findViewById(R.id.txtdata);
        vzv = findViewById(R.id.vzv2);

        Intent intent =getIntent();
        position = intent.getExtras().getInt("position");

        tvid.setText("Номер объявления: "+BDdriver.employeeArrayList.get(position).getIddriver());
        id_name.setText("Имя: "+BDdriver.employeeArrayList.get(position).getIdname());
        tvpynktA.setText("Город отправки: "+BDdriver.employeeArrayList.get(position).getPynktA());
        tvpynktB.setText("Город прибытия: "+BDdriver.employeeArrayList.get(position).getPynktB());
        tvavto.setText("Автомобиль: "+BDdriver.employeeArrayList.get(position).getAvto());
        tvphone.setText(BDdriver.employeeArrayList.get(position).getPhone());
        tvdata.setText("Дата выезда: "+BDdriver.employeeArrayList.get(position).getDataw());

        String phoneNo = tvphone.getText().toString();

        vzv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent in = new Intent(Intent.ACTION_VIEW, Uri.parse(String.format("tel:%s", phoneNo)));
                startActivity(in);
            }
        });

    }
}

package com.example.login;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.format.DateUtils;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class DriverActivity extends AppCompatActivity {

    private TextView pr_em, d_data;
    private EditText d_pynktA,d_pynktB,d_phone,d_avto;
    String str_pynktA,str_pynktB,str_phone,str_data, str_eml, str_avto;
    String url = "http://78.107.58.201/driver.php";
  //  String url = "http://192.168.71.227/driver.php";
    Calendar dateAndTime=Calendar.getInstance();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver);

        pr_em=findViewById(R.id.pr_email);
        d_pynktA=findViewById(R.id.d_pynktA);
        d_pynktB= findViewById(R.id.d_pynktB);
        d_data=findViewById(R.id.d_data);
        d_phone = findViewById(R.id.d_phone);
        d_avto = findViewById(R.id.d_avto);

        String txtName = getIntent().getStringExtra("email");
        pr_em.setText(pr_em.getText().toString() + " " + txtName);




    }


    public void moveToDriver(View view) {

        startActivity(new Intent(getApplicationContext(),DriverActivity.class));
        finish();
    }

    public void Driver(View view){

        final ProgressDialog progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Please Wait..");

        if (d_pynktA.getText().toString().equals("")) {
            Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
        } else if (d_pynktB.getText().toString().equals("")) {
            Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
        } else if (d_phone.getText().toString().equals("")) {
            Toast.makeText(this, "Введите телефон", Toast.LENGTH_SHORT).show();
        } else if (d_avto.getText().toString().equals("")) {
            Toast.makeText(this, "Введите телефон", Toast.LENGTH_SHORT).show();
        }else if (d_data.getText().toString().equals("")) {
            Toast.makeText(this, "Введите дату отправки", Toast.LENGTH_SHORT).show();
        } else {

            progressDialog.show();
            str_pynktA = d_pynktA.getText().toString().trim();
            str_pynktB = d_pynktB.getText().toString().trim();
            str_avto = d_avto.getText().toString().trim();
            str_phone = d_phone.getText().toString().trim();
            str_data = d_data.getText().toString().trim();
            str_eml = pr_em.getText().toString().trim();

            StringRequest driver = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    progressDialog.dismiss();
                    d_pynktA.setText("");
                    d_pynktB.setText("");
                    d_avto.setText("");
                    d_phone.setText("");
                    d_data.setText("");
                    pr_em.setText("");
                    Toast.makeText(DriverActivity.this, response, Toast.LENGTH_SHORT).show();
                }
            }, new Response.ErrorListener() {

                @Override
                public void onErrorResponse(VolleyError error) {
                    progressDialog.dismiss();
                    Toast.makeText(DriverActivity.this, error.getMessage().toString(), Toast.LENGTH_SHORT).show();
                }
            }

            ) {
                @Override
                protected Map<String, String> getParams() throws AuthFailureError {
                    Map<String, String> params = new HashMap<String, String>();

                    params.put("pynktA", str_pynktA);
                    params.put("pynktB", str_pynktB);
                    params.put("avto", str_avto);
                    params.put("phone", str_phone);
                    params.put("data", str_data);
                    params.put("id_user", str_eml);
                    return params;

                }
            };

            RequestQueue requestQueue = Volley.newRequestQueue(DriverActivity.this);
            requestQueue.add(driver);

        }

    }




    public void setDate(View v) {
        new DatePickerDialog(DriverActivity.this, d,
                dateAndTime.get(Calendar.YEAR),
                dateAndTime.get(Calendar.MONTH),
                dateAndTime.get(Calendar.DAY_OF_MONTH))
                .show();

    }


    private void setInitialDateTime() {

        d_data.setText(DateUtils.formatDateTime(this,
                dateAndTime.getTimeInMillis(),
                DateUtils.FORMAT_SHOW_DATE | DateUtils.FORMAT_SHOW_YEAR
        ));
    }



    DatePickerDialog.OnDateSetListener d=new DatePickerDialog.OnDateSetListener() {
        public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
            dateAndTime.set(Calendar.YEAR, year);
            dateAndTime.set(Calendar.MONTH, monthOfYear);
            dateAndTime.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            setInitialDateTime();
        }
    };




}

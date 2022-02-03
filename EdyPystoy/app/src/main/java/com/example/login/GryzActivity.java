package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
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

import java.util.HashMap;
import java.util.Map;

public class GryzActivity extends AppCompatActivity {

   private TextView pr_em;
   private EditText t_pynktA,t_pynktB,t_gryz,t_phone,t_price;
   String str_pynktA,str_pynktB,str_gryz,str_phone,str_price, str_eml;
    String url = "http://78.107.58.201/DBgryz.php";
   // String url = "http://192.168.71.227/DBgryz.php";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gryz);

        pr_em=findViewById(R.id.pr_email);
        t_pynktA=findViewById(R.id.t_pynktA);
        t_pynktB= findViewById(R.id.t_pynktB);
        t_gryz=findViewById(R.id.t_gryz);
        t_phone = findViewById(R.id.t_phone);
        t_price = findViewById(R.id.t_price);

        String txtName = getIntent().getStringExtra("email");
        pr_em.setText(pr_em.getText().toString() + " " + txtName);
    }

    public void moveToZakaz(View view) {

        startActivity(new Intent(getApplicationContext(),GryzActivity.class));
        finish();
    }

    public void Zakaz(View view){

        final ProgressDialog progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Please Wait..");

        if (t_pynktA.getText().toString().equals("")) {
            Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
        } else if (t_pynktB.getText().toString().equals("")) {
            Toast.makeText(this, "Введите город", Toast.LENGTH_SHORT).show();
        } else if (t_gryz.getText().toString().equals("")) {
            Toast.makeText(this, "Введите груз", Toast.LENGTH_SHORT).show();
        } else if (t_phone.getText().toString().equals("")) {
            Toast.makeText(this, "Введите телефон", Toast.LENGTH_SHORT).show();
        } else if (t_price.getText().toString().equals("")) {
            Toast.makeText(this, "Введите цену", Toast.LENGTH_SHORT).show();
        } else {

            progressDialog.show();
            str_pynktA = t_pynktA.getText().toString().trim();
            str_pynktB = t_pynktB.getText().toString().trim();
            str_gryz = t_gryz.getText().toString().trim();
            str_phone = t_phone.getText().toString().trim();
            str_price = t_price.getText().toString().trim();
            str_eml = pr_em.getText().toString().trim();

            StringRequest zakaz = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    progressDialog.dismiss();
                    t_pynktA.setText("");
                    t_pynktB.setText("");
                    t_gryz.setText("");
                    t_phone.setText("");
                    t_price.setText("");
                    pr_em.setText("");
                    Toast.makeText(GryzActivity.this, response, Toast.LENGTH_SHORT).show();
                }
            }, new Response.ErrorListener() {

                @Override
                public void onErrorResponse(VolleyError error) {
                    progressDialog.dismiss();
                    Toast.makeText(GryzActivity.this, error.getMessage().toString(), Toast.LENGTH_SHORT).show();
                }
            }

            ) {
                @Override
                protected Map<String, String> getParams() throws AuthFailureError {
                    Map<String, String> params = new HashMap<String, String>();

                    params.put("pynktA", str_pynktA);
                    params.put("pynktB", str_pynktB);
                    params.put("vid", str_gryz);
                    params.put("phone", str_phone);
                    params.put("price", str_price);
                    params.put("id_user", str_eml);
                    return params;

                }
            };

            RequestQueue requestQueue = Volley.newRequestQueue(GryzActivity.this);
            requestQueue.add(zakaz);

        }

    }
}

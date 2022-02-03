package com.example.login;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ProfilActivity extends AppCompatActivity {

    Button aps;
    ListView listView;
    MyAdapter3 adapter;
    private TextView pr_em, fdf, idusers, nameuser,passworduser;
    String pr_em1;
    public static ArrayList<Employee3> employeeArrayList = new ArrayList<>();
    String url = "http://78.107.58.201/profil.php";
  //  String url = "http://192.168.71.227/profil.php";
    Employee3 employee;
  //  int position;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profil);

       aps = findViewById(R.id.obyavl);
        pr_em=findViewById(R.id.pr_email);
        fdf = findViewById(R.id.fdf);

        String txtName = getIntent().getStringExtra("email");
        pr_em.setText(pr_em.getText().toString() + " " + txtName);
        fdf.setText(fdf.getText().toString() + " " + txtName);


        listView = findViewById(R.id.myListprofil);
        adapter = new MyAdapter3(this,employeeArrayList);
        listView.setAdapter(adapter);
        aps.setOnClickListener(
                v -> {
                    Intent intent = new Intent(ProfilActivity.this, MyADSActivity.class);
                    intent.putExtra("fdf",fdf.getText().toString());
                    startActivity(intent);

                });




        retrieveData();
//
    }


    public void retrieveData() {
        pr_em1 = pr_em.getText().toString().trim();
        StringRequest request = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                        employeeArrayList.clear();
                        try {

                            JSONObject jsonObject = new JSONObject(response);
                            String sucess = jsonObject.getString("success");
                            JSONArray jsonArray = jsonObject.getJSONArray("users");
                            pr_em.setText("");

                            if (sucess.equals("1")) {


                                for (int i = 0; i < jsonArray.length(); i++) {

                                    JSONObject object = jsonArray.getJSONObject(i);

                                    String iduser = object.getString("idusers");
                                    String name = object.getString("name");
                                    String email = object.getString("email");
                                    String password = object.getString("password");


                                    employee = new Employee3(iduser,name,email,password);
                                    employeeArrayList.add(employee);
                                    adapter.notifyDataSetChanged();


                                }


                            }


                        } catch (JSONException e) {
                            e.printStackTrace();
                        }


                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(ProfilActivity.this, error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        })
    {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("email", pr_em1);
                return params;

            }
        };

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(request);
    }

}

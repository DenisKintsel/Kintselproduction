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

public class MyADSActivity extends AppCompatActivity {



    ListView listView;
    MyAdapter4 adapter;
    String url = "http://78.107.58.201/myapss.php";
    String url1 = "http://78.107.58.201/myapsTo.php";
 //   String url = "http://192.168.71.227/myapss.php";
   // String url1 = "http://192.168.71.227/myapsTo.php";
    private TextView ap_email , fdf;
    String str_aps, sts_fdf;
    Employee4 employee;
    public static ArrayList<Employee4> employeeArrayList = new ArrayList<>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_ads);

        fdf = findViewById(R.id.fdfa);
        ap_email = findViewById(R.id.AP_email);
        listView = findViewById(R.id.myListASP);
        adapter = new MyAdapter4(this,employeeArrayList);
        listView.setAdapter(adapter);

        String txtName = getIntent().getStringExtra("fdf");
        ap_email.setText(ap_email.getText().toString() + " " + txtName);
        fdf.setText(fdf.getText().toString() + " " + txtName);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {

                AlertDialog.Builder builder = new AlertDialog.Builder(view.getContext());
                ProgressDialog progressDialog = new ProgressDialog(view.getContext());

                CharSequence[] dialogItem = {"Удалить объявление"};
                builder.setTitle(employeeArrayList.get(position).getIdAP());
                builder.setItems(dialogItem, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {

                        switch (i){

                            case 0:

                                deleteData(employeeArrayList.get(position).getIdAP());

                                break;


                        }



                    }
                });


                builder.create().show();


            }
        });



        employeeArrayList.clear();
        retrieveData();
        retrieveDataTo();
    }

    private void deleteData(final String idAP) {
        sts_fdf = fdf.getText().toString().trim();
        StringRequest request = new StringRequest(Request.Method.POST, "http://192.168.71.227/delete.php",
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        if(response.equalsIgnoreCase("Data Deleted")){
                            Toast.makeText(MyADSActivity.this, "Удаленно, обновите раздел", Toast.LENGTH_SHORT).show();
                        }
                        else{
                            Toast.makeText(MyADSActivity.this, "Data Not Deleted", Toast.LENGTH_SHORT).show();
                    }


                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(MyADSActivity.this, error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }){
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {

                Map<String,String> params = new HashMap<String,String>();
                params.put("id", idAP);
                params.put("email", sts_fdf);
                return params;
            }
        };

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(request);



    }


    public void retrieveData() {
        str_aps = ap_email.getText().toString().trim();
        StringRequest request = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                       // employeeArrayList.clear();
                        try {

                            JSONObject jsonObject = new JSONObject(response);
                            String sucess = jsonObject.getString("success");
                            JSONArray jsonArray = jsonObject.getJSONArray("users_driver");
                            ap_email.setText("");

                            if (sucess.equals("1")) {


                                for (int i = 0; i < jsonArray.length(); i++) {

                                    JSONObject object = jsonArray.getJSONObject(i);

                                    String idAP = object.getString("iddriver");
                                    String danAP = object.getString("avto");
                                    String dan2AP = object.getString("data");
                                  //  String dan3AP = object.getString("password");


                                    employee = new Employee4(idAP, danAP,dan2AP);
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
                Toast.makeText(MyADSActivity.this, error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        })
        {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("email", str_aps);
                return params;

            }
        };


        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(request);
    }

    public void retrieveDataTo() {
        str_aps = ap_email.getText().toString().trim();
        StringRequest request = new StringRequest(Request.Method.POST, url1,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                        //employeeArrayList.clear();
                        try {

                            JSONObject jsonObject = new JSONObject(response);
                            String sucess = jsonObject.getString("success");
                            JSONArray jsonArray = jsonObject.getJSONArray("users_driver");
                          //  JSONArray jsonArray_gruz = jsonObject.getJSONArray("users_driver");
                            ap_email.setText("");

                            if (sucess.equals("1")) {

                                for (int i = 0; i < jsonArray.length(); i++) {

                                    JSONObject object = jsonArray.getJSONObject(i);
                                    String idAP = object.getString("idgryz");
                                    String danAP = object.getString("pynktA");
                                    String dan2AP = object.getString("vid");
                                    // String dan3AP = object.getString("password");


                                    employee = new Employee4(idAP, danAP,dan2AP);
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
                Toast.makeText(MyADSActivity.this, error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        })
        {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("email", str_aps);
                return params;

            }
        };

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(request);


    }
}

package com.example.login;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
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

public class PoiskActivity extends AppCompatActivity {

    private TextView pr_em,pr_em2;
    ListView listView;
    MyAdapter adapter;
    public static ArrayList<Employee> employeeArrayList = new ArrayList<>();
    String url = "http://78.107.58.201/vbn4.php";
  //  String url = "http://192.168.71.227/vbn4.php";
    Employee employee;
    String str_em, str_em2;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_poisk);

        listView = findViewById(R.id.myListView);
        adapter = new MyAdapter(this,employeeArrayList);
        listView.setAdapter(adapter);
        pr_em = findViewById(R.id.pr_em);
        pr_em2 = findViewById(R.id.pr_em2);

        String txtName = getIntent().getStringExtra("pkt");
        pr_em.setText(pr_em.getText().toString() + " " + txtName);
        String txtNamee = getIntent().getStringExtra("pktB");
        pr_em2.setText(pr_em2.getText().toString() + " " + txtNamee);


        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {

                AlertDialog.Builder builder = new AlertDialog.Builder(view.getContext());
                ProgressDialog progressDialog = new ProgressDialog(view.getContext());

                CharSequence[] dialogItem = {"Открыть объявление"};
                builder.setTitle(employeeArrayList.get(position).getPynktA());
                builder.setItems(dialogItem, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {

                        switch (i){

                            case 0:

                                startActivity(new Intent(getApplicationContext(),DetailActivity.class)
                                        .putExtra("position",position));

                                break;


                        }



                    }
                });


                builder.create().show();


            }
        });



        retrieveData();
    }
    public void retrieveData() {
        str_em = pr_em.getText().toString().trim();
        str_em2 = pr_em2.getText().toString().trim();
        StringRequest request = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {


                        employeeArrayList.clear();
                        try {

                            JSONObject jsonObject = new JSONObject(response);
                            String sucess = jsonObject.getString("success");
                            JSONArray jsonArray = jsonObject.getJSONArray("gryz");
                            pr_em.setText("");
                            pr_em2.setText("");

                            if (sucess.equals("1")) {


                                for (int i = 0; i < jsonArray.length(); i++) {

                                    JSONObject object = jsonArray.getJSONObject(i);

                                    String idname = object.getString("name");
                                    String idgryz = object.getString("idgryz");
                                    String pynktA = object.getString("pynktA");
                                    String pynktB = object.getString("pynktB");
                                    String vid = object.getString("vid");
                                    String price = object.getString("price");
                                    String phone = object.getString("phone");

                                    employee = new Employee(idgryz, idname, pynktA, pynktB, vid,price,phone);
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

                Toast.makeText(PoiskActivity.this, error.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }) {

            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                params.put("pktA", str_em);
                params.put("pktB", str_em2);
                return params;
            }

        };


        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(request);
    }



    }






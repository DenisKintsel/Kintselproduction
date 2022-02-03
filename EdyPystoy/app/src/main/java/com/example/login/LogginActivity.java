package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
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

import java.util.HashMap;
import java.util.Map;

import static com.example.login.Session.ID;

public class LogginActivity extends AppCompatActivity {

    EditText ed_email,ed_password, ed_idss;

    String str_email,str_password, str_idss;
   String url = "http://78.107.58.201/qwer.php";
  //  String url = "http://192.168.71.227/qwer.php";
    Session sessionManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_loggin);

        sessionManager = new Session(this);

        ed_email = findViewById(R.id.ed_email);
        ed_password = findViewById(R.id.ed_password);
        ed_idss = findViewById(R.id.ed_idss);

    }

    public void Login(View view) {

        if(ed_email.getText().toString().equals("")){
            Toast.makeText(this, "Введите Email", Toast.LENGTH_SHORT).show();
        }
        else if(ed_password.getText().toString().equals("")){
            Toast.makeText(this, "Введите Password", Toast.LENGTH_SHORT).show();
        }
        else{


            final ProgressDialog progressDialog = new ProgressDialog(this);
            progressDialog.setMessage("Please Wait..");

            progressDialog.show();

            str_email = ed_email.getText().toString().trim();
            str_password = ed_password.getText().toString().trim();
            str_idss = ed_idss.getText().toString().trim();


            StringRequest request = new StringRequest(Request.Method.POST, url,
                    new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            try {

                                JSONObject jsonObject = new JSONObject(response);
                                String sucess = jsonObject.getString("success");
                                JSONArray jsonArray = jsonObject.getJSONArray("gryz");

                                if(response.equalsIgnoreCase("Гуд")) {

                                    ed_email.setText("");
                                    ed_password.setText("");

                                    for (int i = 0; i < jsonArray.length(); i++) {

                                        JSONObject object = jsonArray.getJSONObject(i);

                                        String ed_idss = object.getString("idusers");

                                       // str_idss = ed_idss.getText().toString().trim();

                                    }


                                }


                            } catch (JSONException e) {
                                e.printStackTrace();
                            }


                        }
                    }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {

                    Toast.makeText(LogginActivity.this, error.getMessage().toString(), Toast.LENGTH_SHORT).show();
                }
            }



           /* StringRequest request = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    progressDialog.dismiss();

                    if(response.equalsIgnoreCase("Гуд")){

                        ed_email.setText("");
                        ed_password.setText("");
//                        ed_idss.setText("");


                        startActivity(new Intent(getApplicationContext(),VxodActivity.class));
                        Toast.makeText(LogginActivity.this, response, Toast.LENGTH_SHORT).show();
                       sessionManager.createSession(str_email);
   //                    sessionManager.createSession(str_idss);
                    }
                    else{
                        Toast.makeText(LogginActivity.this, response, Toast.LENGTH_SHORT).show();
                    }

                }
            },new Response.ErrorListener(){

                @Override
                public void onErrorResponse(VolleyError error) {
                    progressDialog.dismiss();
                    Toast.makeText(LogginActivity.this, error.getMessage().toString(), Toast.LENGTH_SHORT).show();
                }
            }*/

            ){
                @Override
                protected Map<String, String> getParams() throws AuthFailureError {
                    Map<String,String> params = new HashMap<String, String>();
                    params.put("email",str_email);
                    params.put("password",str_password);
                    return params;

                }
            };

            RequestQueue requestQueue = Volley.newRequestQueue(LogginActivity.this);
            requestQueue.add(request);




        }
    }

    public void moveToRegistration(View view) {
        startActivity(new Intent(getApplicationContext(),Login22.class));
        finish();
    }
}

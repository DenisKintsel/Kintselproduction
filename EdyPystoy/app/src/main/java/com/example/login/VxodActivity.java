package com.example.login;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;

import org.json.JSONException;
import org.json.JSONObject;
import android.view.Menu;
import android.view.MenuItem;

import java.util.ArrayList;
import java.util.HashMap;

public class VxodActivity extends AppCompatActivity {

    private TextView email, idss;
    Session  sessionManager;
    private Button btn, button, bt_driver, profil;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vxod);
        sessionManager = new Session(this);
        sessionManager.checkLogin();


        bt_driver= findViewById(R.id.driver);
        profil = findViewById(R.id.profil);


        button = findViewById(R.id.button);
        button.setOnClickListener(
                v -> {
                    Intent intent = new Intent(VxodActivity.this, PKGryzActivity.class);
                    startActivity(intent);

                });
        bt_driver.setOnClickListener(
                v -> {
                    Intent intent = new Intent(VxodActivity.this, PKDriverActivity.class);
                    startActivity(intent);

                });
        profil.setOnClickListener(
                v -> {
                    Intent intent = new Intent(VxodActivity.this, ProfilActivity.class);
                    intent.putExtra("email",email.getText().toString());
                    startActivity(intent);

                });


        email = findViewById(R.id.email);
        btn = findViewById(R.id.but);

        HashMap<String,String>user = sessionManager.getUserDetail();
        String mEmail = user.get(sessionManager.EMAIL);
     //  String midss = user.get(sessionManager.ID);

        email.setText(mEmail);
  //      idss.setText(midss);

        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sessionManager.logout();
            }
        });


    }


    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.vp_menu,menu);
        return super.onCreateOptionsMenu(menu);
    }
    public void onAbout(MenuItem item) {
        //Toast.makeText(this, "gfggh", Toast.LENGTH_SHORT).show();
        switch (item.getItemId()) {
            case R.id.gryz:
                Intent intent = new Intent(VxodActivity.this, GryzActivity.class);
                intent.putExtra("email",email.getText().toString());
                startActivity(intent);

        }
        return;
    }
    public void onAbout1 (MenuItem item){

        switch (item.getItemId()){
            case R.id.drive:
                Intent intent = new Intent(VxodActivity.this,DriverActivity.class);
                intent.putExtra("email",email.getText().toString());
                startActivity(intent);
        }
    }


}

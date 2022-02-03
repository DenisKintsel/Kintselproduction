package com.example.login;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;



import java.util.HashMap;

public class Session {

    SharedPreferences sharedPreferences;
    public SharedPreferences.Editor editor;
    public Context context;
    int PRIVATE_MODE = 0;
  //  String str_idss;

    private static final String PREF_NAME = "LOGIN";
    private static final String LOGIN = "IS_LOGIN";
    public static final String NAME = "NAME";
    public static final String EMAIL = "email";
    public static final String ID = "idusers";

    public Session(Context context) {
        this.context = context;
        sharedPreferences = context.getSharedPreferences(PREF_NAME, PRIVATE_MODE);
        editor = sharedPreferences.edit();
    }

    public void createSession(String str_emailo){

        editor.putBoolean(LOGIN, true);
      // editor.putString(NAME, name);
        editor.putString(EMAIL, str_emailo);
     //   editor.putString(ID, str_idss);
        editor.apply();

    }


    public boolean isLoggin(){
        return sharedPreferences.getBoolean(LOGIN, false);
    }

    public void checkLogin(){

        if (!this.isLoggin()){
            Intent i = new Intent(context, LogginActivity.class);
            context.startActivity(i);
            ((VxodActivity) context).finish();
        }
    }

    public HashMap<String, String> getUserDetail(){

        HashMap<String, String> user = new HashMap<>();
        user.put(NAME, sharedPreferences.getString(NAME, null));
        user.put(EMAIL, sharedPreferences.getString(EMAIL, null));
       user.put(ID, sharedPreferences.getString(ID, null));

        return user;
    }

    public void logout(){

        editor.clear();
        editor.commit();
        Intent i = new Intent(context,LogginActivity.class);
        context.startActivity(i);
        ((VxodActivity) context).finish();

    }


}

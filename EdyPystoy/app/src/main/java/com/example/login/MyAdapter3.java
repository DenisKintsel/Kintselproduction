package com.example.login;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.List;

public class MyAdapter3 extends ArrayAdapter<Employee3> {

    Context context;
    List<Employee3> arrayListEmployee;

    public MyAdapter3(@NonNull Context context, List<Employee3> arrayListEmployee) {
        super(context, R.layout.custom_profil_item, arrayListEmployee);

        this.context = context;
        this.arrayListEmployee = arrayListEmployee;

    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.custom_profil_item,null,true);

        TextView iduser = view.findViewById(R.id.iduser);
      TextView name = view.findViewById(R.id.nameusers);
      TextView email = view.findViewById(R.id.emailusers);
      TextView password = view.findViewById(R.id.passwordusers);





        iduser.setText(arrayListEmployee.get(position).getIduser());
        name.setText("Имя: "+arrayListEmployee.get(position).getName());
        email.setText("Email: "+arrayListEmployee.get(position).getEmail());
        password.setText("Пароль: "+arrayListEmployee.get(position).getPassword());


        return view;
    }
}

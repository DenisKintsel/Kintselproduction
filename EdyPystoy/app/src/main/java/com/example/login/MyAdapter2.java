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

public class MyAdapter2 extends ArrayAdapter<Employee2> {

    Context context;
    List<Employee2> arrayListEmployee;

    public MyAdapter2(@NonNull Context context, List<Employee2> arrayListEmployee) {
        super(context, R.layout.custom_driver_item, arrayListEmployee);

        this.context = context;
        this.arrayListEmployee = arrayListEmployee;

    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.custom_driver_item,null,true);

        TextView tvID = view.findViewById(R.id.txt_id);
        TextView tvgdA = view.findViewById(R.id.txt_gd1);
        TextView tvgdB = view.findViewById(R.id.txt_gd2);
        TextView dataw = view.findViewById(R.id.txt_gd3);


        tvID.setText(arrayListEmployee.get(position).getIddriver());
        tvgdA.setText(arrayListEmployee.get(position).getPynktA());
        tvgdB.setText(arrayListEmployee.get(position).getPynktB());
        dataw.setText(arrayListEmployee.get(position).getDataw());


        return view;
    }
}

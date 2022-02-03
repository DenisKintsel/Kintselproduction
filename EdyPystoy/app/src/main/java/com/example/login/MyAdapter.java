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

public class MyAdapter extends ArrayAdapter<Employee> {

    Context context;
    List<Employee> arrayListEmployee;

    public MyAdapter(@NonNull Context context, List<Employee> arrayListEmployee) {
        super(context, R.layout.custom_list_item,arrayListEmployee);

        this.context = context;
        this.arrayListEmployee = arrayListEmployee;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.custom_list_item,null,true);

        TextView tvID = view.findViewById(R.id.txt_id);
        TextView tvgtA = view.findViewById(R.id.txt_gtA);
        TextView tvgtB = view.findViewById(R.id.txt_gtB);
        TextView tvgryz = view.findViewById(R.id.txt_gt3);


        tvID.setText(arrayListEmployee.get(position).getIdgryz());
        tvgtA.setText(arrayListEmployee.get(position).getPynktA());
        tvgtB.setText(arrayListEmployee.get(position).getPynktB());
        tvgryz.setText(arrayListEmployee.get(position).getVid());

        return view;
    }
}

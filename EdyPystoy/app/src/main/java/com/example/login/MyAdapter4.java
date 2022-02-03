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

public class MyAdapter4 extends ArrayAdapter <Employee4> {

    Context context;
    List<Employee4> arrayListEmployee;

    public MyAdapter4(@NonNull Context context, List<Employee4> arrayListEmployee) {
        super(context, R.layout.custom_myaps_item, arrayListEmployee);

        this.context = context;
        this.arrayListEmployee = arrayListEmployee;

    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.custom_myaps_item,null,true);

        TextView idAP = view.findViewById(R.id.APS_id);
        TextView danAP = view.findViewById(R.id.APS_gd1);
        TextView dan2AP = view.findViewById(R.id.APS_gd2);
      //  TextView dan3AP = view.findViewById(R.id.APS_gd3);





        idAP.setText(arrayListEmployee.get(position).getIdAP());
        danAP.setText(arrayListEmployee.get(position).getDanAP());
        dan2AP.setText(arrayListEmployee.get(position).getDan2AP());



        return view;
    }

}

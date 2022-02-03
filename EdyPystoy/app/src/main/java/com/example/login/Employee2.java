package com.example.login;

public class Employee2 {

    private String idname,iddriver, pynktA, pynktB, avto, phone, dataw, id_users;

    public Employee2() {
    }

    public Employee2(String idname,String iddriver, String pynktA, String pynktB, String avto, String phone, String dataw) {
        this.idname = idname;
        this.iddriver = iddriver;
        this.pynktA = pynktA;
        this.pynktB = pynktB;
        this.avto = avto;
        this.phone = phone;
        this.dataw = dataw;
        //this.id_users = id_users;
    }

    public String getIdname() {
        return idname;
    }

    public void setIdname(String iddriver) {
        this.idname = idname;
    }

    public String getIddriver() {
        return iddriver;
    }

    public void setIddriver(String iddriver) {
        this.iddriver = iddriver;
    }

    public String getPynktA() {
        return pynktA;
    }

    public void setPynktA(String pynktA) {
        this.pynktA = pynktA;
    }

    public String getPynktB() {
        return pynktB;
    }

    public void setPynktB(String pynktB) {
        this.pynktB = pynktB;
    }

    public String getAvto() {
        return avto;
    }

    public void setAvto(String avto) {
        this.avto = avto;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDataw() {
        return dataw;
    }

    public void setDataw(String dataw) {
        this.dataw = dataw;
    }


}

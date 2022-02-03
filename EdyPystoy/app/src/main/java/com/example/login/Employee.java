package com.example.login;

public class Employee {


    private String idname, idgryz,pynktA,pynktB,vid,price, phone;

    public Employee() {
    }

    public Employee(String idname, String idgryz, String pynktA, String pynktB, String vid, String price, String phone) {
        this.idname = idname;
        this.idgryz = idgryz;
        this.pynktA = pynktA;
        this.pynktB = pynktB;
        this.vid = vid;
        this.price = price;
        this.phone = phone;
    }

    public String getIdname() {
        return idname;
    }

    public void setIdname(String idgryz) {
        this.idname = idname;
    }

    public String getIdgryz() {
        return idgryz;
    }

    public void setIdgryz(String idgryz) {
        this.idgryz = idgryz;
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

    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}

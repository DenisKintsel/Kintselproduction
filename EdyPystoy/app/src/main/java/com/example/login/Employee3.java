package com.example.login;

public class Employee3 {

    private String iduser,name,email,password;

    public Employee3() {
    }

    public Employee3(String iduser, String name, String email, String password) {
        this.iduser = iduser;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public String getIduser() {
        return iduser;
    }

    public void setIduser(String idusers) {
        this.iduser = iduser;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

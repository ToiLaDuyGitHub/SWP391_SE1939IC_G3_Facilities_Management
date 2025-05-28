/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dto;

import model.User;
import model.Role;
/**
 *
 * @author ADMIN
 */
public class User_Role {

    private String username;
    private String firstName;
    private String lastName;
    private String phoneNum ;   
    private String address;
    private String roleName ;
    
    public User_Role(String username,String firstName, String lastName,String phoneNum,String address, String roleName ){
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNum = phoneNum;        
        this.address = address;
        this.roleName = roleName;
    }

    public String getUsername() {
        return username;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public String getRoleName() {
        return roleName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
}

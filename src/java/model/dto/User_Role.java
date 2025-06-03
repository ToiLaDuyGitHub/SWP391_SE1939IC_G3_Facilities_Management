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
    private int roleID ;
    private int userID;
    private boolean isActive;

    public User_Role(String username, String firstName, String lastName, String phoneNum, String address, String roleName, int roleID, boolean isActive) {
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNum = phoneNum;
        this.address = address;
        this.roleName = roleName;
        this.roleID = roleID;
        this.isActive = isActive;
        
    }
    public User_Role(int userID, String username, String firstName, String lastName, String phoneNum, int roleID, String roleName, boolean isActive) {
        this.userID = userID;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNum = phoneNum;
        this.roleID = roleID;
        this.roleName = roleName;
        this.isActive = isActive;
    }
    
    public User_Role(int userID, String username, String firstName, String lastName, 
                     String phoneNum, String address, String roleName, boolean isActive) {
        this.userID = userID;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNum = phoneNum;
        this.address = address;
        this.roleName = roleName;
        this.isActive = isActive;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public int getUserID() {
        return userID;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    
}

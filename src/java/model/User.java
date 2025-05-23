/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class User {
    int UserID;
    String Username;
    String Password;
    String FirstName;
    String LastName;
    String PhoneNum;
    Date RegistrasionDate;
    byte IsActive;

    public User() {
        
    }

    public User(int UserID, String Username, String Password, String FirstName, String LastName, String PhoneNum, Date RegistrasionDate, byte IsActive) {
        this.UserID = UserID;
        this.Username = Username;
        this.Password = Password;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.PhoneNum = PhoneNum;
        this.RegistrasionDate = RegistrasionDate;
        this.IsActive = IsActive;
    }

    public int getUserID() {
        return UserID;
    }

    public String getUsername() {
        return Username;
    }

    public String getPassword() {
        return Password;
    }

    public String getFirstName() {
        return FirstName;
    }

    public String getLastName() {
        return LastName;
    }

    public String getPhoneNum() {
        return PhoneNum;
    }

    public Date getRegistrasionDate() {
        return RegistrasionDate;
    }

    public byte getIsActive() {
        return IsActive;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public void setPhoneNum(String PhoneNum) {
        this.PhoneNum = PhoneNum;
    }

    public void setRegistrasionDate(Date RegistrasionDate) {
        this.RegistrasionDate = RegistrasionDate;
    }

    public void setIsActive(byte IsActive) {
        this.IsActive = IsActive;
    }
    
}

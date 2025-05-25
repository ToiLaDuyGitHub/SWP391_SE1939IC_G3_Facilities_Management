/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;


/**
 *
 * @author ToiLaDuyGitHub
 */
public class User {
    private int userID;
    private String username;
    private String passwordHash;
    private String firstName;
    private String lastName;
    private int roleID;
    private String phoneNum;
    private LocalDateTime registrationDate;
    private boolean isActive;
    private String resetOTP;
    private LocalDateTime resetOTPTime;

    public User(int userID, String username, int roleID) {
        this.userID = userID;
        this.username = username;
        this.roleID = roleID;
    }

    public User(String username, String passwordHash, String firstName, String lastName, int roleID, String phoneNum, LocalDateTime registrationDate, boolean isActive, String resetOTP, LocalDateTime resetOTPTime) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.firstName = firstName;
        this.lastName = lastName;
        this.roleID = roleID;
        this.phoneNum = phoneNum;
        this.registrationDate = registrationDate;
        this.isActive = isActive;
        this.resetOTP = resetOTP;
        this.resetOTPTime = resetOTPTime;
    }

    public User(String username, LocalDateTime resetOTPTime) {
        this.username = username;
        this.resetOTPTime = resetOTPTime;
    }

    public User(int userID, String username, String passwordHash, String firstName, String lastName, int roleID, String phoneNum, LocalDateTime registrationDate, boolean isActive, String resetOTP, LocalDateTime resetOTPTime) {
        this.userID = userID;
        this.username = username;
        this.passwordHash = passwordHash;
        this.firstName = firstName;
        this.lastName = lastName;
        this.roleID = roleID;
        this.phoneNum = phoneNum;
        this.registrationDate = registrationDate;
        this.isActive = isActive;
        this.resetOTP = resetOTP;
        this.resetOTPTime = resetOTPTime;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
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

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public LocalDateTime getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(LocalDateTime registrationDate) {
        this.registrationDate = registrationDate;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getResetOTP() {
        return resetOTP;
    }

    public void setResetOTP(String resetOTP) {
        this.resetOTP = resetOTP;
    }

    public LocalDateTime getResetOTPTime() {
        return resetOTPTime;
    }

    public void setResetOTPTime(LocalDateTime resetOTPTime) {
        this.resetOTPTime = resetOTPTime;
    }
}

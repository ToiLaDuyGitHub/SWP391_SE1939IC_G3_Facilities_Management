/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class Supplier {
    private int supplierID;
    private String supplierName;
    private String address;
    private String phoneNum;

    public Supplier() {
    }

    public Supplier(int supplierID, String supplierName) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
    }

    public Supplier(int supplierID, String supplierName, String address, String phoneNum) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.address = address;
        this.phoneNum = phoneNum;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

   
}

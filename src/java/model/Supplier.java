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
    private int SupplierID;
    private String SupplierName;
    private String Address;
    private String PhoneNum;

    public Supplier() {
    }

    public Supplier(int SupplierID, String SupplierName, String Address, String PhoneNum) {
        this.SupplierID = SupplierID;
        this.SupplierName = SupplierName;
        this.Address = Address;
        this.PhoneNum = PhoneNum;
    }

    public int getSupplierID() {
        return SupplierID;
    }

    public void setSupplierID(int SupplierID) {
        this.SupplierID = SupplierID;
    }

    public String getSupplierName() {
        return SupplierName;
    }

    public void setSupplierName(String SupplierName) {
        this.SupplierName = SupplierName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getPhoneNum() {
        return PhoneNum;
    }

    public void setPhoneNum(String PhoneNum) {
        this.PhoneNum = PhoneNum;
    }

    
}

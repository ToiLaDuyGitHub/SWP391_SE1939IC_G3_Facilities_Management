/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class FacilityCondition {
    private int facilityID;
    private int newQuantity;
    private int usableQuantity;
    private int brokenQuantity;

    public FacilityCondition(int facilityID, int newQuantity, int usableQuantity, int brokenQuantity) {
        this.facilityID = facilityID;
        this.newQuantity = newQuantity;
        this.usableQuantity = usableQuantity;
        this.brokenQuantity = brokenQuantity;
    }

    public int getFacilityID() {
        return facilityID;
    }

    public void setFacilityID(int facilityID) {
        this.facilityID = facilityID;
    }

    public int getNewQuantity() {
        return newQuantity;
    }

    public void setNewQuantity(int newQuantity) {
        this.newQuantity = newQuantity;
    }

    public int getUsableQuantity() {
        return usableQuantity;
    }

    public void setUsableQuantity(int usableQuantity) {
        this.usableQuantity = usableQuantity;
    }

    public int getBrokenQuantity() {
        return brokenQuantity;
    }

    public void setBrokenQuantity(int brokenQuantity) {
        this.brokenQuantity = brokenQuantity;
    }
}

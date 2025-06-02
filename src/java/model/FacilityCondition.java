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
    private int FacilityID;
    private int NewQuantity;
    private int UsableQuantity;
    private int BrokenQuantity;

 

    public FacilityCondition(int facilityID, int newQuantity, int usableQuantity, int brokenQuantity) {
        this.FacilityID = facilityID;
        this.NewQuantity = newQuantity;
        this.UsableQuantity = usableQuantity;
        this.BrokenQuantity = brokenQuantity;
    }

    public int getFacilityID() {
        return FacilityID;
    }

    public void setFacilityID(int facilityID) {
        this.FacilityID = facilityID;
    }

    public int getNewQuantity() {
        return NewQuantity;
    }

    public void setNewQuantity(int newQuantity) {
        this.NewQuantity = newQuantity;
    }

    public int getUsableQuantity() {
        return UsableQuantity;
    }

    public void setUsableQuantity(int usableQuantity) {
        this.UsableQuantity = usableQuantity;
    }

    public int getBrokenQuantity() {
        return BrokenQuantity;
    }

    public void setBrokenQuantity(int brokenQuantity) {
        this.BrokenQuantity = brokenQuantity;
    }
      @Override
    public String toString() {
        return "New: " + NewQuantity + ", Usable: " + UsableQuantity + ", Broken: " + BrokenQuantity;
    }
}

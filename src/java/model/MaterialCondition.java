/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class MaterialCondition {
    private int MaterialID;
    private int NewQuantity;
    private int UsableQuantity;
    private int BrokenQuantity;

 

    public MaterialCondition(int materialID, int newQuantity, int usableQuantity, int brokenQuantity) {
        this.MaterialID = materialID;
        this.NewQuantity = newQuantity;
        this.UsableQuantity = usableQuantity;
        this.BrokenQuantity = brokenQuantity;
    }

    public int getMaterialID() {
        return MaterialID;
    }

    public void setMaterialID(int materialID) {
        this.MaterialID = materialID;
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

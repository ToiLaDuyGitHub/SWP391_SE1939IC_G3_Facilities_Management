/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class MaterialQuantity {
    private int materialID;
    private int usableQuantity;
    private int brokenQuantity;
    private int totalQuantity;

    public MaterialQuantity() {
    }

    public MaterialQuantity(int materialID, int usableQuantity, int brokenQuantity, int totalQuantity) {
        this.materialID = materialID;
        this.usableQuantity = usableQuantity;
        this.brokenQuantity = brokenQuantity;
        this.totalQuantity = totalQuantity;
    }

  

    public int getMaterialID() {
        return materialID;
    }

    public void setMaterialID(int materialID) {
        this.materialID = materialID;
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

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

   
    
    
    
}

/*
 * Click nfs://.netbeans/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://.netbeans/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dto;

import model.Category;
import model.SubCategory;
import model.Supplier;

/**
 *
 * @author Admin
 */
public class MaterialDTO {
    private int materialID;
    private String materialName;
    private String supplierName;
    private String minUnit;
    private String maxUnit;

    public MaterialDTO() {
    }

    public int getMaterialID() {
        return materialID;
    }

    public void setMaterialID(int materialID) {
        this.materialID = materialID;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getMinUnit() {
        return minUnit;
    }

    public void setMinUnit(String minUnit) {
        this.minUnit = minUnit;
    }

    public String getMaxUnit() {
        return maxUnit;
    }

    public void setMaxUnit(String maxUnit) {
        this.maxUnit = maxUnit;
    }

    public MaterialDTO(int materialID, String materialName, String supplierName, String minUnit, String maxUnit) {
        this.materialID = materialID;
        this.materialName = materialName;
        this.supplierName = supplierName;
        this.minUnit = minUnit;
        this.maxUnit = maxUnit;
    }

}
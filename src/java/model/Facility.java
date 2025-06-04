/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author acer
 */
public class Facility {
    private int FacilityID;
    private String FacilityName;
    private Category category;
    private SubCategory subcategory;
    private Supplier SupplierID;
    private String Image;
    private int Quantity;
    private FacilityCondition condition;
private String Detail;
    public Facility() {
    }

    public Facility(int FacilityID, String FacilityName, Category category, SubCategory subcategory, Supplier SupplierID, String Image, int Quantity, FacilityCondition condition, String Detail) {
        this.FacilityID = FacilityID;
        this.FacilityName = FacilityName;
        this.category = category;
        this.subcategory = subcategory;
        this.SupplierID = SupplierID;
        this.Image = Image;
        this.Quantity = Quantity;
        this.condition = condition;
        this.Detail = Detail;
    }

    public int getFacilityID() {
        return FacilityID;
    }

    public void setFacilityID(int FacilityID) {
        this.FacilityID = FacilityID;
    }

    public String getFacilityName() {
        return FacilityName;
    }

    public void setFacilityName(String FacilityName) {
        this.FacilityName = FacilityName;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public SubCategory getSubcategory() {
        return subcategory;
    }

    public void setSubcategory(SubCategory subcategory) {
        this.subcategory = subcategory;
    }

    public Supplier getSupplierID() {
        return SupplierID;
    }

    public void setSupplierID(Supplier SupplierID) {
        this.SupplierID = SupplierID;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public FacilityCondition getCondition() {
        return condition;
    }

    public void setCondition(FacilityCondition condition) {
        this.condition = condition;
    }

    public String getDetail() {
        return Detail;
    }

    public void setDetail(String Detail) {
        this.Detail = Detail;
    }

    

}

   
    
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author acer
 */
public class Material {
    private int MaterialID;
    private String MaterialName;
    private Category category;
    private SubCategory subcategory;
    private Supplier SupplierID;
    private String Image;
    private int Quantity;
    private MaterialCondition condition;
private String Detail;
    public Material() {
    }

    public Material(int MaterialID, String MaterialName, Category category, SubCategory subcategory, Supplier SupplierID, String Image, int Quantity, MaterialCondition condition, String Detail) {
        this.MaterialID = MaterialID;
        this.MaterialName = MaterialName;
        this.category = category;
        this.subcategory = subcategory;
        this.SupplierID = SupplierID;
        this.Image = Image;
        this.Quantity = Quantity;
        this.condition = condition;
        this.Detail = Detail;
    }

    public int getMaterialID() {
        return MaterialID;
    }

    public void setMaterialID(int MaterialID) {
        this.MaterialID = MaterialID;
    }

    public String getMaterialName() {
        return MaterialName;
    }

    public void setMaterialName(String MaterialName) {
        this.MaterialName = MaterialName;
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

    public MaterialCondition getCondition() {
        return condition;
    }

    public void setCondition(MaterialCondition condition) {
        this.condition = condition;
    }

    public String getDetail() {
        return Detail;
    }

    public void setDetail(String Detail) {
        this.Detail = Detail;
    }

    

}

   
    
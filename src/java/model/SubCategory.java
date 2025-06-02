/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class SubCategory {
    private int SubcategoryID;
    private int CategoryID;
    private String SubcategoryName;

    public SubCategory() {
    }

    public SubCategory(int SubcategoryID, int CategoryID, String SubcategoryName) {
        this.SubcategoryID = SubcategoryID;
        this.CategoryID = CategoryID;
        this.SubcategoryName = SubcategoryName;
    }

    public int getSubcategoryID() {
        return SubcategoryID;
    }

    public void setSubcategoryID(int SubcategoryID) {
        this.SubcategoryID = SubcategoryID;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getSubcategoryName() {
        return SubcategoryName;
    }

    public void setSubcategoryName(String SubcategoryName) {
        this.SubcategoryName = SubcategoryName;
    }

    
}

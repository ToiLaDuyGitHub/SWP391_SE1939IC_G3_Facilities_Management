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
    private int subcategoryID;
    private int categoryID;
    private String subcategoryName;

    // Constructor với tất cả tham số
    public SubCategory(int subcategoryID, int categoryID, String subcategoryName) {
        this.subcategoryID = subcategoryID;
        this.categoryID = categoryID;
        this.subcategoryName = subcategoryName;
    }

    // Constructor không có ID (dùng khi insert)
    public SubCategory(int categoryID, String subcategoryName) {
        this.categoryID = categoryID;
        this.subcategoryName = subcategoryName;
    }

    public SubCategory() {
    }
    
    

    public int getSubcategoryID() {
        return subcategoryID;
    }

    public void setSubcategoryID(int subcategoryID) {
        this.subcategoryID = subcategoryID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getSubcategoryName() {
        return subcategoryName;
    }

    public void setSubcategoryName(String subcategoryName) {
        this.subcategoryName = subcategoryName;
    }

    // toString method
    @Override
    public String toString() {
        return "SubCategory{" +
                "subcategoryID=" + subcategoryID +
                ", categoryID=" + categoryID +
                ", subcategoryName='" + subcategoryName + '\'' +
                '}';
    }

    // equals và hashCode methods
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        SubCategory that = (SubCategory) obj;
        return subcategoryID == that.subcategoryID;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(subcategoryID);
    }
}

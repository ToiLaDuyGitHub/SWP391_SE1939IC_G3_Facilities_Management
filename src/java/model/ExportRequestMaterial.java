/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class ExportRequestMaterial {
    private int exportRequestID;
    private int materialID;
    private int quantity;

    public ExportRequestMaterial() {
    }

    public ExportRequestMaterial(int exportRequestID, int materialID, int quantity) {
        this.exportRequestID = exportRequestID;
        this.materialID = materialID;
        this.quantity = quantity;
    }

    public int getExportRequestID() {
        return exportRequestID;
    }

    public void setExportRequestID(int exportRequestID) {
        this.exportRequestID = exportRequestID;
    }

    public int getMaterialID() {
        return materialID;
    }

    public void setMaterialID(int materialID) {
        this.materialID = materialID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

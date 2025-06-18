/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.security.Timestamp;

/**
 *
 * @author ADMIN
 */
public class ExportRequest {
    private int exportRequestID;
    private int createdByID;
    private Integer approvedByID;
    private Timestamp createdDate;
    private Timestamp approvedDate;
    private String note;
    private int status;

    public ExportRequest() {
    }

    public ExportRequest(int exportRequestID, int createdByID, Integer approvedByID, 
                        Timestamp createdDate, Timestamp approvedDate, String note, int status) {
        this.exportRequestID = exportRequestID;
        this.createdByID = createdByID;
        this.approvedByID = approvedByID;
        this.createdDate = createdDate;
        this.approvedDate = approvedDate;
        this.note = note;
        this.status = status;
    }

    public ExportRequest(int createdByID, String note) {
        this.createdByID = createdByID;
        this.note = note;
        this.status = 0;
    }

    public int getExportRequestID() {
        return exportRequestID;
    }

    public void setExportRequestID(int exportRequestID) {
        this.exportRequestID = exportRequestID;
    }

    public int getCreatedByID() {
        return createdByID;
    }

    public void setCreatedByID(int createdByID) {
        this.createdByID = createdByID;
    }

    public Integer getApprovedByID() {
        return approvedByID;
    }

    public void setApprovedByID(Integer approvedByID) {
        this.approvedByID = approvedByID;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(Timestamp approvedDate) {
        this.approvedDate = approvedDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}

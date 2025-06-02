/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Feature {
    private int UrlID;
    private String UrlName ;
    private String Url;

    public Feature(int UrlID, String UrlName, String Url) {
        this.UrlID = UrlID;
        this.UrlName = UrlName;
        this.Url = Url;
    }

    public int getUrlID() {
        return UrlID;
    }

    public void setUrlID(int UrlID) {
        this.UrlID = UrlID;
    }

    public String getUrlName() {
        return UrlName;
    }

    public void setUrlName(String UrlName) {
        this.UrlName = UrlName;
    }

    public String getUrl() {
        return Url;
    }

    public void setUrl(String Url) {
        this.Url = Url;
    }
    
}

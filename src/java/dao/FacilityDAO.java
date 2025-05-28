package dao;

import util.DBUtil;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class FacilityDAO {
    public static class Facility {
        private int facilityId;
        private String facilityName;
        private String categoryName;
        private String supplierName;
        private int quantity;
        private int newQuantity;
        private int usableQuantity;
        private int brokenQuantity;
        private String image;

        public Facility(int facilityId, String facilityName, String categoryName, String supplierName,
                        int quantity, int newQuantity, int usableQuantity, int brokenQuantity, String image) {
            this.facilityId = facilityId;
            this.facilityName = facilityName;
            this.categoryName = categoryName;
            this.supplierName = supplierName;
            this.quantity = quantity;
            this.newQuantity = newQuantity;
            this.usableQuantity = usableQuantity;
            this.brokenQuantity = brokenQuantity;
            this.image = image;
        }

        // Getters
        public int getFacilityId() { return facilityId; }
        public String getFacilityName() { return facilityName; }
        public String getCategoryName() { return categoryName; }
        public String getSupplierName() { return supplierName; }
        public int getQuantity() { return quantity; }
        public int getNewQuantity() { return newQuantity; }
        public int getUsableQuantity() { return usableQuantity; }
        public int getBrokenQuantity() { return brokenQuantity; }
        public String getImage() { return image != null ? image : "img/default.jpg"; }
    }

    public List<Facility> getAllFacilities() throws SQLException {
        List<Facility> facilities = new ArrayList<>();
        String sql = "SELECT f.FacilityID, f.FacilityName, c.CategoryName, s.SupplierName, f.Quantity, " +
                     "fc.NewQuantity, fc.UsableQuantity, fc.BrokenQuantity, f.Image " +
                     "FROM facilities f " +
                     "JOIN categories c ON f.CategoryID = c.CategoryID " +
                     "JOIN suppliers s ON f.SupplierID = s.SupplierID " +
                     "LEFT JOIN facilityconditions fc ON f.FacilityID = fc.FacilityID";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Facility facility = new Facility(
                    rs.getInt("FacilityID"),
                    rs.getString("FacilityName"),
                    rs.getString("CategoryName"),
                    rs.getString("SupplierName"),
                    rs.getInt("Quantity"),
                    rs.getInt("NewQuantity"),
                    rs.getInt("UsableQuantity"),
                    rs.getInt("BrokenQuantity"),
                    rs.getString("Image")
                );
                facilities.add(facility);
            }
        }
        return facilities;
    }
}
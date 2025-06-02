/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.FacilityDAO;
import model.Facility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.nio.file.Paths;

/**
 *
 * @author Admin
 */
@WebServlet(name="EditFacilityController", urlPatterns={"/EditFacility"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditFacilityController extends HttpServlet {
   private static final String UPLOAD_DIR = "uploads";
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        FacilityDAO facilityDAO = new FacilityDAO();
       try {
            // Lấy các tham số từ form trong JSP
            int facilityID = Integer.parseInt(request.getParameter("facilityID")); // ID của vật tư
            String facilityName = request.getParameter("materialName"); // Tên vật tư
            int subcategoryID = Integer.parseInt(request.getParameter("subcategoryID")); // ID danh mục con
            int quantity = Integer.parseInt(request.getParameter("quantity")); // Số lượng tổng
            int newQuantity = Integer.parseInt(request.getParameter("statusNew")); // Số lượng mới
            int usableQuantity = Integer.parseInt(request.getParameter("statusOld")); // Số lượng sử dụng được
            int brokenQuantity = Integer.parseInt(request.getParameter("statusDamaged")); // Số lượng hỏng
            String supplierName = request.getParameter("supplier"); // Tên nhà cung cấp
            String supplierAddress = request.getParameter("supplierAddress"); // Địa chỉ nhà cung cấp
            String supplierPhone = request.getParameter("supplierPhone"); // Số điện thoại nhà cung cấp
            String oldImageUrl = request.getParameter("imageUrl"); // URL hình ảnh cũ

            // Xử lý upload hình ảnh mới
            String imageUrl = oldImageUrl; // Mặc định giữ URL hình ảnh cũ
            Part filePart = request.getPart("image"); // Lấy file từ form
            if (filePart != null && filePart.getSize() > 0) {
                // Lấy tên file
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Đường dẫn lưu trữ file trên server
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // Tạo thư mục nếu chưa tồn tại
                }
                // Lưu file vào thư mục uploads
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                // Cập nhật imageUrl với đường dẫn mới
                imageUrl = UPLOAD_DIR + "/" + fileName;
            }

            // Gọi phương thức updateFacility trong FacilityDAO để cập nhật thông tin vật tư vào cơ sở dữ liệu
            facilityDAO.updateFacility(facilityID, facilityName, subcategoryID, supplierName, supplierAddress, supplierPhone, imageUrl, quantity, newQuantity, usableQuantity, brokenQuantity);

            // Sau khi cập nhật thành công, lấy lại thông tin vật tư đã cập nhật để hiển thị
            request.setAttribute("successMessage", "Cập nhật vật tư thành công!");
            Facility updatedFacility = facilityDAO.getFacilityByName(facilityName);
            request.setAttribute("facility", updatedFacility);
            request.getRequestDispatcher("/EditFacility.jsp").forward(request, response);

        } catch (SQLException e) {
            // Xử lý lỗi liên quan đến cơ sở dữ liệu
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật vật tư: " + e.getMessage());
            request.getRequestDispatcher("/EditFacility.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi người dùng nhập sai định dạng số (ví dụ: nhập chữ vào ô số lượng)
            request.setAttribute("errorMessage", "Vui lòng nhập đúng định dạng số cho các trường số lượng!");
            request.getRequestDispatcher("/EditFacility.jsp").forward(request, response);
        }
    }
    
    

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

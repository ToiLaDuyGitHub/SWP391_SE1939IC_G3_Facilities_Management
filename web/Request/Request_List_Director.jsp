<%-- 
    Document   : Request_List_Director
    Created on : 17 thg 6, 2025, 13:27:49
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách yêu cầu</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=wap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <style>
            .search-container {
                margin-bottom: 20px;
                display: flex;
                gap: 10px;
                align-items: center;
            }
            .search-container input[type="text"] {
                width: 300px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 6px;
            }
            .material-table {
                width: 100%;
                min-width: 1400px;
                margin-top: 0;
            }
            .material-table table {
                width: 100%;
                border-collapse: collapse;
            }
            .material-table th, .material-table td {
                padding: 15px 20px;
                text-align: center;
                border: 1px solid #ddd;
            }
            .material-table th {
                background: #f9a825;
                color: #4a90e2;
                font-weight: 600;
                position: sticky;
                top: 0;
                z-index: 1;
            }
            .material-table td a {
                color: #4a90e2;
                text-decoration: none;
            }
            .material-table td a:hover {
                text-decoration: underline;
            }
            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                z-index: 1000;
                width: 600px;
                max-height: 80vh;
                overflow-y: auto;
            }
            .modal.show {
                display: block;
            }
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }
            .modal-overlay.show {
                display: block;
            }
            .modal .close {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 20px;
                cursor: pointer;
            }
            .modal .form-row {
                margin-bottom: 15px;
            }
            .modal .form-row.inline {
                display: flex;
                gap: 20px;
            }
            .modal label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
            }
            .modal input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                background: #f9f9f9;
                
            }
            .modal .material-table {
                margin-top: 15px;
                min-width: 100%;
            }
            .modal .material-table th, .modal .material-table td {
                padding: 10px;
            }
            .material-table td button {
                padding: 8px 12px;
                background: #4a90e2;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }
            .material-table td button:hover {
                background: #357abd;
            }
            @media (max-width: 1200px) {
                .content-card {
                    max-width: 95%;
                    padding: 15px;
                }
                .search-container input[type="text"] {
                    width: 200px;
                }
                .material-table {
                    min-width: 1000px;
                }
            }
            @media (max-width: 768px) {
                .search-container {
                    flex-direction: column;
                    gap: 10px;
                }
                .search-container input[type="text"] {
                    width: 100%;
                }
                .material-table {
                    min-width: 800px;
                }
                .material-table th, .material-table td {
                    padding: 10px 15px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/sidebar.jsp" %>
        <div class="content">
            <div class="" id="requestListSection">
                <h2><i class="fas fa-list"></i> Danh sách yêu cầu </h2>
                <div class="search-container">
                    <input type="text" id="searchInput" placeholder="Tìm kiếm yêu cầu..." onkeyup="searchTable()">
                    <button onclick="searchTable()"><i class="fas fa-search"></i> Tìm</button>
                </div>
                <div class="material-table">
                    <table>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Loại đơn</th>
                            <th>Ngày tạo</th>
                            <th>Người tạo</th>
                            <th>Tình trạng</th>
                            <th>Hành động</th>
                        </tr>
                        <c:choose>
                            <c:when test="${not empty processedRequests}">
                                <c:forEach var="request" items="${processedRequests}">
                                    <tr>
                                        <td>${request.requestCode}</td>
                                        <td>${request.requestType}</td>
                                        <td>${request.createdDate}</td>
                                        <td>${request.createdByName}</td>
                                        <td>${request.statusText}</td>
                                        <td>
                                            <button onclick="showRequestDetail('${request.requestId}')">Xem chi tiết</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6">Không có yêu cầu nào để hiển thị.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </table>
                </div>
            </div>
        </div>
        <!-- Modal for Request Details -->
        <div id="editModal" class="modal">
            <span class="close" onclick="closeEditModal()">×</span>
            <h3>Chi tiết yêu cầu</h3>
            <div class="form-row inline">
                <div>
                    <label for="requestCode">Mã đơn</label>
                    <input type="text" id="requestCode" readonly>
                </div>
                <div>
                    <label for="requestType">Loại đơn</label>
                    <input type="text" id="requestType" readonly>
                </div>
                <div>
                    <label for="statusText">Tình trạng</label>
                    <input type="text" id="statusText" readonly>
                </div>
            </div>
            <div class="form-row inline">
                <div>
                    <label for="createdByName">Người tạo</label>
                    <input type="text" id="createdByName" readonly>
                </div>
                <div>
                    <label for="createdDate">Ngày tạo</label>
                    <input type="text" id="createdDate" readonly>
                </div>
            </div>
            <div class="form-row">
                <label>Vật tư trong đơn</label>
                <div class="material-table">
                    <table>
                        <tr>
                            <th>Tên vật tư</th>
                            <th>Số lượng</th>
                        </tr>
                        <tbody id="materialTableBody">
                            <tr><td></td><td></td></tr> <!-- Placeholder row -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="button-group">
                <button class="close-btn" onclick="closeEditModal()">Đóng</button>
            </div>
        </div>
        <div id="editModalOverlay" class="modal-overlay"></div>
        <script>
            function searchTable() {
                let input = document.getElementById("searchInput").value.toLowerCase();
                let table = document.getElementById("requestTableBody");
                let tr = table.getElementsByTagName("tr");

                for (let i = 0; i < tr.length; i++) {
                    let td = tr[i].getElementsByTagName("td");
                    let found = false;
                    for (let j = 0; j < td.length - 1; j++) {
                        if (td[j]) {
                            let text = td[j].textContent || td[j].innerText;
                            if (text.toLowerCase().indexOf(input) > -1) {
                                found = true;
                                break;
                            }
                        }
                    }
                    tr[i].style.display = found ? "" : "none";
                }
            }

            function showRequestDetail(requestId) {
                document.getElementById("editModal").classList.add("show");
                document.getElementById("editModalOverlay").classList.add("show");
            }

            function closeEditModal() {
                document.getElementById("editModal").classList.remove("show");
                document.getElementById("editModalOverlay").classList.remove("show");
            }

            // Close modal when clicking overlay
            document.getElementById("editModalOverlay").addEventListener("click", closeEditModal);
        </script>
    </body>
</html>
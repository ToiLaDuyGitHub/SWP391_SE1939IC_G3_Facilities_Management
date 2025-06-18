<%-- 
    Document   : Request_List
    Created on : Jun 12, 2025, 13:35:46
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách yêu cầu xuất đã xử lý</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <style>
            .content-card {
                max-width: 1500px;
                margin: 20px auto;
                padding: 25px;
            }
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
                min-width: 1000px;
                margin-top: 0;
            }
            .material-table th, .material-table td {
                padding: 12px 15px;
                text-align: center;
            }
            .material-table th {
                background: #f9a825;
                color: #4a90e2;
                font-weight: 600;
                position: sticky;
                top: 0;
                z-index: 1;
            }
            .edit-button {
                padding: 8px 12px;
                background: #4a90e2;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s;
            }
            .edit-button:hover {
                background: #357abd;
            }
            @media (max-width: 1200px) {
                .content-card {
                    max-width: 90%;
                    padding: 15px;
                }
                .search-container input[type="text"] {
                    width: 200px;
                }
                .material-table {
                    min-width: 800px;
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
                    min-width: 600px;
                }
                .material-table th, .material-table td {
                    padding: 8px 10px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/sidebar.jsp" %>
        <div class="content">
            <div class="content-card" id="requestListSection">
                <h2><i class="fas fa-list"></i> Danh sách yêu cầu xuất đã xử lý</h2>
                <div class="search-container">
                    <input type="text" id="searchInput" placeholder="Tìm kiếm yêu cầu..." onkeyup="searchTable()">
                    <button onclick="searchTable()"><i class="fas fa-search"></i> Tìm</button>
                </div>
                <div class="material-table">
                    <table>
                        <tr>
                            <th>ID Yêu cầu</th>
                            <th>Ngày tạo</th>
                            <th>Người tạo</th>
                            <th>Người duyệt</th>
                            <th>Hành động</th>
                        </tr>
                        <c:choose>
                            <c:when test="${not empty processedRequests}">
                                <c:forEach var="request" items="${processedRequests}">
                                    <tr>
                                        <td>${request.exportRequestID}</td>
                                        <td>${request.createdDate}</td>
                                        <td>${request.createdByName}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty request.approvedByName}">
                                                    ${request.approvedByName}
                                                </c:when>
                                                <c:otherwise>
                                                    Chưa có người duyệt
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="export-request-details?id=${request.exportRequestID}">Xem chi tiết</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5">Không có yêu cầu xuất nào để hiển thị.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </table>
                </div>
            </div>
        </div>
        <script>
            function searchTable() {
                let input = document.getElementById("searchInput").value.toLowerCase();
                let table = document.getElementById("requestTableBody");
                let tr = table.getElementsByTagName("tr");

                for (let i = 0; i < tr.length; i++) {
                    let td = tr[i].getElementsByTagName("td");
                    let found = false;
                    for (let j = 0; j < td.length - 1; j++) { // Bỏ qua cột hành động
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
                window.location.href = "${pageContext.request.contextPath}/view-request-detail?requestId=" + requestId + "&type=Export";
            }
        </script>
    </body>
</html>

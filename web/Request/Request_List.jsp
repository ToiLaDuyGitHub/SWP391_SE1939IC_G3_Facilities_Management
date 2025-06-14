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
        <title>Danh sách các yêu cầu</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <style>
            .content-card {
                max-width: 1500px; /* Tăng chiều rộng tối đa để bảng hiển thị tốt hơn */
                margin: 20px auto;
                padding: 25px; /* Tăng padding để giao diện thoáng hơn */
            }
            .search-container {
                margin-bottom: 20px;
                display: flex;
                gap: 10px;
                align-items: center;
            }
            .search-container input[type="text"] {
                width: 300px; /* Giảm chiều rộng ô tìm kiếm để cân đối */
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 6px;
            }
            .material-table {
                min-width: 1000px; /* Đảm bảo bảng không quá hẹp */
                margin-top: 0; /* Loại bỏ margin-top để sát với ô tìm kiếm */
            }
            .material-table th, .material-table td {
                padding: 12px 15px; /* Tăng padding cho cột để dễ đọc */
                text-align: center; /* Căn giữa nội dung */
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
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                gap: 5px;
            }
            .pagination a {
                padding: 8px 12px;
                text-decoration: none;
                color: #4a90e2;
                border: 1px solid #ddd;
                border-radius: 4px;
                transition: background 0.3s;
            }
            .pagination a:hover, .pagination a.active {
                background: #f9a825;
                color: #fff;
                border-color: #f9a825;
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
                <h2><i class="fas fa-list"></i> Danh sách các yêu cầu</h2>
                <div class="search-container">
                    <input type="text" id="searchInput" placeholder="Tìm kiếm yêu cầu..." onkeyup="searchTable()">
                    <button onclick="searchTable()"><i class="fas fa-search"></i> Tìm</button>
                </div>
                <div class="material-table">
                    <table>
                        <thead>
                            <tr>
                                <th>ID Yêu cầu</th>
                                <th>Ngày tạo</th>
                                <th>Người tạo</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody id="requestTableBody">
                            <c:forEach var="request" items="${requestList}">
                                <tr>
                                    <td>${request.id}</td>
                                    <td>${request.createdDate}</td>
                                    <td>${request.createdBy}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${request.status == 'PENDING'}">
                                                <span style="color: orange;">Đang chờ xử lý</span>
                                            </c:when>
                                            <c:when test="${request.status == 'APPROVED'}">
                                                <span style="color: green;">Đã phê duyệt</span>
                                            </c:when>
                                            <c:when test="${request.status == 'REJECTED'}">
                                                <span style="color: red;">Bị từ chối</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${request.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="edit-button" onclick="showRequestDetail('${request.id}')">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty requestList}">
                                <tr>
                                    <td colspan="5" style="text-align: center; padding: 20px;">Không có yêu cầu nào để hiển thị.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <c:if test="${totalPages > 1}">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="${pageContext.request.contextPath}/Request_list.jsp?page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </c:if>
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
                    for (let j = 0; j < td.length - 1; j++) { // Skip the action column
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
                window.location.href = "${pageContext.request.contextPath}/view-request-detail?requestId=" + requestId;
            }
        </script>
    </body>
</html>
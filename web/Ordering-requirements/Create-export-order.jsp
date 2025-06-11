<%-- 
    Document   : Create-export-order
    Created on : Jun 11, 2025, 03:45 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn Xuất Kho</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>

            .content {
                margin-left: 250px; 
                margin-top: 0;
                padding: 20px;
            }

            .content-card {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                display: flex;
                flex-direction: column;
            }

            h2 {
                font-size: 22px;
                color: #1a3c6d;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .search-form {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .search-form input[type="text"] {
                padding: 8px 12px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 14px;
                flex: 1;
                min-width: 250px;
                background: #fafafa;
                transition: border-color 0.3s;
            }

            .search-form input[type="text"]:focus {
                border-color: #0056b3;
                outline: none;
            }

            .search-form button {
                padding: 8px 16px;
                background: #0056b3;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 14px;
                font-weight: 500;
                transition: background 0.3s;
            }

            .search-form button:hover {
                background: #003f87;
            }

            .main-content {
                display: flex;
                gap: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
                background: #fff;
                border-radius: 0;
                overflow: hidden;
                flex: 2;
            }

            table thead {
                background: #f39c12;
                color: #fff;
            }

            table th {
                padding: 12px 15px;
                text-align: left;
                font-weight: 600;
            }

            table td {
                padding: 12px 15px;
                border-bottom: 1px solid #e2e8f0;
            }

            table tbody tr:nth-child(even) {
                background: #f8fafc;
            }

            table tbody tr:hover {
                background: #fef9e7;
                cursor: pointer;
            }

            .quantity-controls {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .quantity-controls button {
                padding: 2px 8px;
                border: 1px solid #d1d5db;
                background: #fff;
                border-radius: 4px;
                cursor: pointer;
            }

            .quantity-controls input {
                width: 40px;
                text-align: center;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                padding: 2px;
            }

            .quantity-unit {
                margin-left: 10px;
                padding: 2px 8px;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                background: #fff;
                display: inline-block;
            }

            .remove-btn {
                background: none;
                border: none;
                cursor: pointer;
                color: #dc3545;
                font-size: 16px;
                padding: 2px;
            }

            .remove-btn:hover {
                color: #c82333;
            }

            .submit-btn {
                padding: 8px 16px;
                background: #28a745;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: background 0.3s;
            }

            .submit-btn:hover {
                background: #218838;
            }

            .summary {
                flex: 1;
                padding: 10px;
                background: #e9ecef;
                border-radius: 6px;
                min-width: 250px;
            }

            .summary textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                margin-top: 10px;
                resize: vertical;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="/sidebar.jsp" %>
            <div class="content" id="contentArea">
                <div class="content-card">
                    <h2>Đơn xuất kho</h2>
                    <form class="search-form" action="${pageContext.request.contextPath}/search-material-in-list" method="get">
                        <input type="text" placeholder="Nhập tên vật tư để tìm kiếm">
                        <button type="submit">Tìm kiếm</button>
                    </form>

                    <div class="main-content">
                        <table>
                            <thead>
                                <tr>
                                    <th>Chọn</th>
                                    <th>Tên vật tư</th>
                                    <th>Số lượng</th>
                                    <th>Đơn vị</th>
                                    <th>Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Nháp tên vật tư</td>
                                    <td>
                                        <div class="quantity-controls">
                                            <button>-</button>
                                            <input type="number" value="1" min="0">
                                            <button>+</button>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="quantity-unit">kg</span>
                                    </td>
                                    <td><button class="remove-btn"><i class="fas fa-trash"></i></button></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Nháp tên vật tư</td>
                                    <td>
                                        <div class="quantity-controls">
                                            <button>-</button>
                                            <input type="number" value="1" min="0">
                                            <button>+</button>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="quantity-unit">g</span>
                                    </td>
                                    <td><button class="remove-btn"><i class="fas fa-trash"></i></button></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>Nháp tên vật tư</td>
                                    <td>
                                        <div class="quantity-controls">
                                            <button>-</button>
                                            <input type="number" value="1" min="0">
                                            <button>+</button>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="quantity-unit">cm</span>
                                    </td>
                                    <td><button class="remove-btn"><i class="fas fa-trash"></i></button></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="summary">
                            <p>Đơn xuất kho</p>
                            <p>Người nhận: giám đốc</p>
                            <p>Số lượng vật tư: 0</p>
                            <label for="notes">Ghi chú:</label>
                            <textarea id="notes" rows="3" placeholder="Nhập ghi chú..."></textarea>
                            <button type="submit" class="submit-btn">Gửi đơn</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="admin-wrapper">

   
    <div class="sidebar">
        <div class="sidebar-logo">
        
            <span></span>
            <p>FreshMart</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/adminDashboard" class="nav-item active">
           
                <span class="nav-icon"></span>
                <span>Dashboard</span>
            </a>
            
            
            <a href="${pageContext.request.contextPath}/inventory" class="nav-item">
                <span class="nav-icon"></span>
                <span>Inventory</span>
            </a>
            <a href="${pageContext.request.contextPath}/addProduct" class="nav-item">
                <span class="nav-icon"></span>
                <span>Add Product</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageOrders" class="nav-item">
                <span class="nav-icon"></span>
                <span>Orders</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageUsers" class="nav-item">
                <span class="nav-icon"></span>
                <span>Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                <span class="nav-icon"></span>
                <span>Logout</span>
            </a>
        </nav>
    </div>

    <div class="main-content">

        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-left">
                <h2>Dashboard</h2>
                <p class="breadcrumb">Welcome back, <strong>${sessionScope.user.fullName}</strong></p>
            </div>
            <div class="topbar-right">
                <div class="admin-badge">
                    <span></span>
                    <span>${sessionScope.user.fullName}</span>
                    <span class="role-tag">Admin</span>
                </div>
            </div>
        </div>

        <!-- ── STATS CARDS ── -->
        <div class="stats-row">
            <div class="stat-card green">
                <div class="stat-icon"></div>
                <div class="stat-info">
                    <p class="stat-label">Total Sales</p>
                    <h3 class="stat-value">Rs. ${totalSales != null ? totalSales : '0.00'}</h3>
                </div>
            </div>
            <div class="stat-card orange">
                <div class="stat-icon"></div>
                <div class="stat-info">
                    <p class="stat-label">Total Orders</p>
                    <h3 class="stat-value">${totalOrders != null ? totalOrders : '0'}</h3>
                </div>
            </div>
            <div class="stat-card blue">
                <div class="stat-icon"></div>
                <div class="stat-info">
                    <p class="stat-label">Total Products</p>
                    <h3 class="stat-value">${totalProducts != null ? totalProducts : '0'}</h3>
                </div>
            </div>
        </div>
        <!-- ── END STATS CARDS ── -->

        <!-- ── TABLES ROW ── -->
        <div class="tables-row">

            <!-- Top Selling Products -->
            <div class="table-card">
                <div class="table-header">
                    <h3>Top Selling Products</h3>
                </div>
                <table class="dashboard-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty productList}">
                                <c:forEach var="product" items="${productList}" varStatus="i">
                                    <tr>
                                        <td>${i.count}</td>
                                        <td>${product.name}</td>
                                        <td>Rs. ${product.price}</td>
                                        <td>
                                            <span class="badge ${product.stockQuantity > 10 ? 'badge-green' : 'badge-red'}">
                                                ${product.stockQuantity} ${product.unit}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="4" class="empty-row">No products found.</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Recent Orders -->
            <div class="table-card">
                <div class="table-header">
                    <h3>Recent Sales</h3>
                </div>
                <table class="dashboard-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentOrders}">
                                <c:forEach var="order" items="${recentOrders}" varStatus="i">
                                    <tr>
                                        <td>${order.orderId}</td>
                                        <td>${order.userName}</td>
                                        <td>Rs. ${order.totalAmount}</td>
                                        <td>
                                            <span class="badge
                                                ${order.orderStatus == 'delivered' ? 'badge-green' :
                                                  order.orderStatus == 'pending'   ? 'badge-orange' :
                                                  order.orderStatus == 'cancelled' ? 'badge-red' : 'badge-blue'}">
                                                ${order.orderStatus}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="4" class="empty-row">No recent orders found.</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </div>
       

    </div>

</div>

</body>
</html>

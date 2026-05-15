<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders - FreshMart Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ManageOrders.css">
</head>
<body>

<div class="admin-wrapper">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <span>🛒</span>
            <p>FreshMart</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/adminDashboard" class="nav-item">
                <span class="nav-icon">🏠</span><span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/inventory" class="nav-item">
                <span class="nav-icon">📦</span><span>Inventory</span>
            </a>
            <a href="${pageContext.request.contextPath}/addProduct" class="nav-item">
                <span class="nav-icon">➕</span><span>Add Product</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageOrders" class="nav-item active">
                <span class="nav-icon">📋</span><span>Orders</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageUsers" class="nav-item">
                <span class="nav-icon">👥</span><span>Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/adminProfile" class="nav-item">
    		<span class="nav-icon">👤</span>
 			 <span>My Profile</span>
			</a>
			
            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                <span class="nav-icon">🚪</span><span>Logout</span>
            </a>
            
        </nav>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- Topbar -->
        <div class="topbar">
            <div class="topbar-left">
                <h2>Manage Orders</h2>
                <p class="breadcrumb">View and update the status of all customer orders.</p>
            </div>
            <div class="topbar-right">
                <div class="admin-badge">
                    <span>${sessionScope.user.fullName}</span>
                    <span class="role-tag">Admin</span>
                </div>
            </div>
        </div>

        <!-- Flash messages -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success">${successMsg}</div>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">${errorMsg}</div>
        </c:if>

        <!-- Filter bar -->
        <div class="filter-bar">
            <form action="${pageContext.request.contextPath}/manageOrders" method="get">
                <div class="search-input-wrap">
                    <span class="search-icon">🔍</span>
                    <input type="text" name="keyword" placeholder="Search by name or order #"
                           value="${keyword}" class="search-input">
                    <button type="submit" class="search-btn">Search</button>
                </div>
                <select name="status" class="filter-select" onchange="this.form.submit()">
                    <option value="">All Statuses</option>
                    <option value="pending"   ${statusFilter == 'pending'   ? 'selected' : ''}>Pending</option>
                    <option value="confirmed" ${statusFilter == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                    <option value="shipped"   ${statusFilter == 'shipped'   ? 'selected' : ''}>Shipped</option>
                    <option value="delivered" ${statusFilter == 'delivered' ? 'selected' : ''}>Delivered</option>
                    <option value="cancelled" ${statusFilter == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>
                <c:if test="${not empty statusFilter or not empty keyword}">
                    <a href="${pageContext.request.contextPath}/manageOrders" class="btn-outline">Clear</a>
                </c:if>
            </form>
        </div>

        <!-- Orders table -->
        <div class="table-card">
            <div class="table-header">
                <h3>All Orders
                    <c:if test="${not empty orderList}"> (${orderList.size()})</c:if>
                </h3>
            </div>

            <table class="dashboard-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Payment</th>
                        <th>Delivery Address</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty orderList}">
                            <c:forEach var="order" items="${orderList}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td><strong>#${order.orderId}</strong></td>
                                    <td>${order.userName}</td>
                                    <td>Rs. ${order.totalAmount}</td>
                                    <td>
                                        <span class="payment-badge ${order.paymentStatus == 'paid' ? 'payment-paid' : 'payment-unpaid'}">
                                            ${order.paymentStatus}
                                        </span>
                                        <br>
                                        <span style="font-size:11px;color:#aaa;">${order.paymentMethod}</span>
                                    </td>
                                    <td>
                                        <span class="order-address" title="${order.shippingAddress}">
                                            ${order.shippingAddress}
                                        </span>
                                    </td>
                                    <td style="font-size:12px;color:#888;">${order.createdAt}</td>
                                    <td>
                                        <span class="badge
                                            ${order.orderStatus == 'delivered' ? 'badge-green'  :
                                              order.orderStatus == 'pending'   ? 'badge-orange' :
                                              order.orderStatus == 'cancelled' ? 'badge-red'    :
                                              order.orderStatus == 'shipped'   ? 'badge-blue'   : 'badge-blue'}">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/manageOrders"
                                              method="post"
                                              style="display:flex;gap:6px;align-items:center;">
                                            <input type="hidden" name="action"  value="updateStatus">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <select name="newStatus" class="status-select">
                                                <option value="pending"   ${order.orderStatus == 'pending'   ? 'selected' : ''}>Pending</option>
                                                <option value="confirmed" ${order.orderStatus == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                                <option value="shipped"   ${order.orderStatus == 'shipped'   ? 'selected' : ''}>Shipped</option>
                                                <option value="delivered" ${order.orderStatus == 'delivered' ? 'selected' : ''}>Delivered</option>
                                                <option value="cancelled" ${order.orderStatus == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                            </select>
                                            <button type="submit" class="btn-status-update">✔</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" class="empty-row">No orders found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

    </div><!-- end main-content -->
</div><!-- end admin-wrapper -->

</body>
</html>

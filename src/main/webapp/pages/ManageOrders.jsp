<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders - FreshMart Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ManageOrders.css">
    <style>
        /* ── ITEMS ROW ── */
        .items-row { display: none; background: #f9fbf9; }
        .items-row.open { display: table-row; }

        .items-inner {
            padding: 14px 20px;
            border-top: 1px dashed #ddd;
        }

        .items-inner table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        .items-inner th {
            text-align: left;
            padding: 8px 12px;
            background: #eef6ee;
            color: #555;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .items-inner td {
            padding: 9px 12px;
            border-bottom: 1px solid #f0f0f0;
            color: #444;
        }
        .items-inner tr:last-child td { border-bottom: none; }
        .items-inner .subtotal { font-weight: 700; color: #2e7d32; }

        /* ── TOGGLE BUTTON ── */
        .btn-items {
            background: none;
            border: 1px solid #27ae60;
            color: #27ae60;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            white-space: nowrap;
            transition: background 0.15s, color 0.15s;
        }
        .btn-items:hover { background: #27ae60; color: white; }

        /* clickable order row */
        .order-main-row { cursor: pointer; }
        .order-main-row:hover td { background: #f5faf5; }
    </style>
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
                <span class="nav-icon">👤</span><span>My Profile</span>
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
                    <span>${sessionScope.adminUser.fullName}</span>
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
                <p style="font-size:12px; color:#aaa; margin-top:4px;">
                    💡 Order row click garda items dekhaucha
                </p>
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

                                <!-- ── MAIN ORDER ROW — click garda items toggle ── -->
                                <tr class="order-main-row"
                                    onclick="toggleItems('items-${order.orderId}', 'icon-${order.orderId}')">
                                    <td>${i.count}</td>
                                    <td>
                                        <strong>#${order.orderId}</strong>
                                        <span id="icon-${order.orderId}"
                                              style="font-size:10px; color:#aaa; margin-left:4px;">▼</span>
                                    </td>
                                    <td>${order.userName}</td>
                                    <td>Rs. <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2"/></td>
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
                                    <td onclick="event.stopPropagation()">
                                        <%-- stopPropagation: status form click garda items toggle nahunun --%>
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

                                <!-- ── ITEMS ROW — hidden by default ── -->
                                <tr class="items-row" id="items-${order.orderId}">
                                    <td colspan="9">
                                        <div class="items-inner">
                                            <c:choose>
                                                <c:when test="${not empty order.items}">
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Product</th>
                                                                <th>Unit Price</th>
                                                                <th>Qty</th>
                                                                <th>Subtotal</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="item" items="${order.items}" varStatus="iLoop">
                                                                <tr>
                                                                    <td>${iLoop.count}</td>
                                                                    <td><strong>${item.productName}</strong></td>
                                                                    <td>Rs. <fmt:formatNumber value="${item.price}" maxFractionDigits="0"/></td>
                                                                    <td>× ${item.quantity}</td>
                                                                    <td class="subtotal">
                                                                        Rs. <fmt:formatNumber value="${item.subtotal}" maxFractionDigits="0"/>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:when>
                                                <c:otherwise>
                                                    <p style="color:#aaa; font-size:13px; margin:0;">
                                                        Items details available xaina.
                                                    </p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
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

<script>
    function toggleItems(itemsId, iconId) {
        var row  = document.getElementById(itemsId);
        var icon = document.getElementById(iconId);

        if (row.classList.contains('open')) {
            row.classList.remove('open');
            icon.innerHTML = '▼';
        } else {
            row.classList.add('open');
            icon.innerHTML = '▲';
        }
    }
</script>

</body>
</html>

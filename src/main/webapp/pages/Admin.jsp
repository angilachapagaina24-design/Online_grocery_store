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
        
           	<span>🛒</span>
            <p>FreshMart</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/adminDashboard" class="nav-item active">
                <span class="nav-icon">🏠</span>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/inventory" class="nav-item ">
                <span class="nav-icon">📦</span>
                <span>Inventory</span>
            </a>
            <a href="${pageContext.request.contextPath}/addProduct" class="nav-item">
                <span class="nav-icon">➕</span>
                <span>Add Product</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageOrders" class="nav-item">
                <span class="nav-icon">📋</span>
                <span>Orders</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageUsers" class="nav-item">
                <span class="nav-icon">👥</span>
                <span>Users</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/adminProfile" class="nav-item">
   			 <span class="nav-icon">👤</span>
  			  <span>My Profile</span>
			</a>


            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                <span class="nav-icon">🚪</span>
                <span>Logout</span>
            </a>
        </nav>
    </div>

    <div class="main-content">

        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-left">
                <h2>Dashboard</h2>
                <p class="breadcrumb">Welcome back, <strong>Admin</strong></p>
            </div>
            <div class="topbar-right">
                <div class="admin-badge">
                    <span></span>
                    <span>Admin</span>
                    <span class="role-tag">Admin</span>
                </div>
            </div>
        </div>

        <!-- ── STATS CARDS ── -->
        <div class="stats-row">
            <div class="stat-card green">
  			  <div class="stat-info">
    		    <span class="stat-label">TOTAL SALES</span>
     		    <span class="stat-value">Rs. ${totalSales}</span>
     		    <span style="font-size:12px; color:#888;">This month</span>
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
                <c:when test="${productList != null and not empty productList}">
                    <c:forEach var="product" items="${productList}" varStatus="i">
                        <tr>
                            <td>${i.index + 1}</td>
                            <td>${product.name}</td>
                            <td>Rs. ${product.price}</td>
                            <td>
                                <span class="badge ${product.stockQuantity gt 10 ? 'badge-green' : 'badge-red'}">
                                    ${product.stockQuantity} ${product.unit}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <tr>
                        <td colspan="4" class="empty-row">No products found.</td>
                    </tr>
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
					        <c:when test="${recentOrders != null and not empty recentOrders}">
					            <c:forEach var="order" items="${recentOrders}" varStatus="i">
					                <tr>
					                    <td>${i.index + 1}</td>
					                    <td>${order.userName}</td>
					                    <td>Rs. ${order.totalAmount}</td>
					                    <td>
					                        <span class="badge
					                            ${order.orderStatus eq 'delivered' ? 'badge-green' :
					                              order.orderStatus eq 'pending' ? 'badge-orange' :
					                              order.orderStatus eq 'cancelled' ? 'badge-red' : 'badge-blue'}">
					                            ${order.orderStatus}
					                        </span>
					                    </td>
					                </tr>
					            </c:forEach>
					        </c:when>
					
					        <c:otherwise>
					            <tr>
					                <td colspan="4" class="empty-row">No recent orders found.</td>
					            </tr>
					        </c:otherwise>
					    </c:choose>
					</tbody>
                </table>
            </div>

        </div>
        
        <%@ page import="java.util.Map" %>

<!-- Monthly Sales Chart -->
<div class="dash-card" style="margin-top: 28px;">
    <h3 style="margin-bottom: 20px;">📈 Monthly Sales — <%= java.time.Year.now().getValue() %></h3>

    <%
        Map<String, Double> monthlySales = (Map<String, Double>) request.getAttribute("monthlySales");
        double maxVal = 1.0;
        if (monthlySales != null) {
            for (double v : monthlySales.values()) if (v > maxVal) maxVal = v;
        }
    %>

    <div style="display:flex; align-items:flex-end; gap:10px; height:200px; padding: 0 10px;">
        <%
            if (monthlySales != null) {
                for (Map.Entry<String, Double> entry : monthlySales.entrySet()) {
                    double pct = (entry.getValue() / maxVal) * 100;
                    String barColor = entry.getValue() > 0 ? "#27ae60" : "#e0e0e0";
        %>
            <div style="display:flex; flex-direction:column; align-items:center; flex:1;">
                <span style="font-size:11px; color:#555; margin-bottom:4px;">
                    <%= entry.getValue() > 0 ? "Rs." + String.format("%.0f", entry.getValue()) : "" %>
                </span>
                <div style="width:100%; background:<%= barColor %>; border-radius:6px 6px 0 0;
                            height:<%= Math.max(pct, 2) %>%; min-height:4px;
                            transition: height 0.3s;">
                </div>
                <span style="font-size:11px; color:#888; margin-top:6px;"><%= entry.getKey() %></span>
            </div>
        <%
                }
            }
        %>
    </div>
</div>
       

    </div>

</div>

</body>
</html>

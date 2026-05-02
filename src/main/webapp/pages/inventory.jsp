<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory - FreshMart Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="admin-wrapper">

    <!-- ===================== SIDEBAR ===================== -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <span>🛒</span>
            <p>FreshMart</p>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                <span class="nav-icon">🏠</span>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item active">
                <span class="nav-icon">📦</span>
                <span>Inventory</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/addProduct" class="nav-item">
                <span class="nav-icon">➕</span>
                <span>Add Product</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manageOrders" class="nav-item">
                <span class="nav-icon">📋</span>
                <span>Orders</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manageUsers" class="nav-item">
                <span class="nav-icon">👥</span>
                <span>Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                <span class="nav-icon">🚪</span>
                <span>Logout</span>
            </a>
        </nav>
    </div>
    <!-- ===================== END SIDEBAR ===================== -->

    <!-- ===================== MAIN CONTENT ===================== -->
    <div class="main-content">

        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-left">
                <h2>Inventory</h2>
                <p class="breadcrumb">Manage all your products here.</p>
            </div>
            <div class="topbar-right">
                <a href="${pageContext.request.contextPath}/admin/addProduct" class="btn-add">
                    ➕ Add New Product
                </a>
            </div>
        </div>

        <!-- ── SUCCESS / ERROR MESSAGES ── -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success">${successMsg}</div>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">${errorMsg}</div>
        </c:if>

        <!-- ── SEARCH BAR ── -->
        <div class="search-bar-row">
            <form action="${pageContext.request.contextPath}/admin/inventory" method="get">
                <div class="search-input-wrap">
                    <span class="search-icon">🔍</span>
                    <input
                        type="text"
                        name="keyword"
                        placeholder="Search products..."
                        value="${param.keyword}"
                        class="search-input"
                    >
                    <button type="submit" class="search-btn">Search</button>
                </div>
            </form>
        </div>

        <!-- ── PRODUCT TABLE ── -->
        <div class="table-card" style="margin-top: 20px;">
            <div class="table-header">
                <h3>All Products
                    <c:if test="${not empty param.keyword}">
                        — results for "<strong>${param.keyword}</strong>"
                    </c:if>
                </h3>
            </div>

            <table class="dashboard-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Product</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <c:forEach var="product" items="${productList}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>

                                    <!-- Product name + image -->
                                    <td>
                                        <div class="product-cell">
                                            <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                 alt="${product.name}"
                                                 class="product-thumb"
                                                 onerror="this.src='${pageContext.request.contextPath}/Images/placeholder.png'">
                                            <div>
                                                <p class="product-cell-name">${product.name}</p>
                                                <p class="product-cell-brand">${product.brand}</p>
                                            </div>
                                        </div>
                                    </td>

                                    <td>${product.categoryId}</td>
                                    <td>Rs. ${product.price}</td>
                                    <td>${product.stockQuantity} ${product.unit}</td>

                                    <!-- Status badge -->
                                    <td>
                                        <span class="badge ${product.status == 'available' ? 'badge-green' : 'badge-red'}">
                                            ${product.status}
                                        </span>
                                    </td>

                                    <!-- Edit + Delete buttons -->
                                    <td class="action-cell">

                                        <%-- EDIT: go to editProduct page with productId --%>
                                        <a href="${pageContext.request.contextPath}/admin/editProduct?productId=${product.productId}"
                                           class="btn-icon btn-edit" title="Edit">
                                            ✏️
                                        </a>

                                        <%-- DELETE: POST form with productId --%>
                                        <form action="${pageContext.request.contextPath}/admin/deleteProduct"
                                              method="post"
                                              style="display:inline;"
                                              onsubmit="return confirm('Are you sure you want to delete ${product.name}?')">
                                            <input type="hidden" name="productId" value="${product.productId}">
                                            <button type="submit" class="btn-icon btn-delete" title="Delete">🗑️</button>
                                        </form>

                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="empty-row">
                                    No products found.
                                    <a href="${pageContext.request.contextPath}/admin/addProduct">Add one now →</a>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <!-- ── END PRODUCT TABLE ── -->

    </div>
    <!-- ===================== END MAIN CONTENT ===================== -->

</div>

</body>
</html>

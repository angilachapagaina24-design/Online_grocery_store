<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - FreshMart Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ManageUsers.css">
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
            <a href="${pageContext.request.contextPath}/manageOrders" class="nav-item">
                <span class="nav-icon">📋</span><span>Orders</span>
            </a>
            <a href="${pageContext.request.contextPath}/manageUsers" class="nav-item active">
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
                <h2>Manage Users</h2>
                <p class="breadcrumb">View, activate, deactivate, or remove users.</p>
            </div>
            <div class="topbar-right">
                <div class="admin-badge">
                    <span>${sessionScope.user.fullName}</span>
                    <span class="role-tag">Admin</span>
                </div>
            </div>
        </div>

        <!-- Stats cards -->
        <div class="stats-row">
            <div class="stat-card blue">
                <div class="stat-icon">👥</div>
                <div class="stat-info">
                    <p class="stat-label">Total Users</p>
                    <h3 class="stat-value">${totalUsers}</h3>
                </div>
            </div>
            <div class="stat-card green">
                <div class="stat-icon">✅</div>
                <div class="stat-info">
                    <p class="stat-label">Active Users</p>
                    <h3 class="stat-value">${activeUsers}</h3>
                </div>
            </div>
            <div class="stat-card orange">
                <div class="stat-icon">🚫</div>
                <div class="stat-info">
                    <p class="stat-label">Inactive Users</p>
                    <h3 class="stat-value">${inactiveUsers}</h3>
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
            <form action="${pageContext.request.contextPath}/manageUsers" method="get">
                <div class="search-input-wrap">
                    <span class="search-icon">🔍</span>
                    <input type="text" name="keyword" placeholder="Search by name, email, phone"
                           value="${keyword}" class="search-input">
                    <button type="submit" class="search-btn">Search</button>
                </div>
                <select name="role" class="filter-select" onchange="this.form.submit()">
                    <option value="">All Roles</option>
                    <option value="admin"    ${roleFilter == 'admin'    ? 'selected' : ''}>Admin</option>
                    <option value="customer" ${roleFilter == 'customer' ? 'selected' : ''}>Customer</option>
                </select>
                <c:if test="${not empty roleFilter or not empty keyword}">
                    <a href="${pageContext.request.contextPath}/manageUsers" class="btn-outline">Clear</a>
                </c:if>
            </form>
        </div>

        <!-- Users table -->
        <div class="table-card">
            <div class="table-header">
                <h3>All Users
                    <c:if test="${not empty userList}"> (${userList.size()})</c:if>
                </h3>
            </div>

            <table class="dashboard-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>User</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty userList}">
                            <c:forEach var="u" items="${userList}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>

                                    <!-- User cell with avatar -->
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar">
                                                ${fn:substring(u.fullName, 0, 1)}
                                            </div>
                                            <div>
                                                <p class="user-cell-name">${u.fullName}</p>
                                                <p class="user-cell-email">${u.email}</p>
                                            </div>
                                        </div>
                                    </td>

                                    <td>${u.phone != null ? u.phone : '—'}</td>
                                    <td>${u.address != null && u.address != '' ? u.address : '—'}</td>

                                    <!-- Role badge -->
                                    <td>
                                        <span class="badge ${u.role == 'admin' ? 'role-admin' : 'role-customer'}">
                                            ${u.role}
                                        </span>
                                    </td>

                                    <!-- Status badge -->
                                    <td>
                                        <span class="badge ${u.status == 'active' ? 'badge-green' : 'badge-red'}">
                                            ${u.status}
                                        </span>
                                    </td>

                                    <!-- Actions -->
                                    <td class="action-cell">
                                        <c:choose>
                                            <c:when test="${u.userId == sessionScope.user.userId}">
                                                <span class="self-note">You</span>
                                            </c:when>
                                            <c:otherwise>

                                                <!-- Toggle active/inactive -->
                                                <form action="${pageContext.request.contextPath}/manageUsers"
                                                      method="post" style="display:inline;">
                                                    <input type="hidden" name="action"        value="toggleStatus">
                                                    <input type="hidden" name="userId"        value="${u.userId}">
                                                    <input type="hidden" name="currentStatus" value="${u.status}">
                                                    <button type="submit"
                                                            class="${u.status == 'active' ? 'btn-toggle-active' : 'btn-toggle-inactive'}"
                                                            title="${u.status == 'active' ? 'Deactivate user' : 'Activate user'}">
                                                        ${u.status == 'active' ? '🚫 Deactivate' : '✅ Activate'}
                                                    </button>
                                                </form>

                                                <!-- Delete -->
                                                <form action="${pageContext.request.contextPath}/manageUsers"
                                                      method="post" style="display:inline;"
                                                      onsubmit="return confirm('Permanently delete ${u.fullName}? This cannot be undone.')">
                                                    <input type="hidden" name="action" value="deleteUser">
                                                    <input type="hidden" name="userId" value="${u.userId}">
                                                    <button type="submit" class="btn-icon btn-delete" title="Delete user">🗑️</button>
                                                </form>

                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="empty-row">No users found.</td>
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

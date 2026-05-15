<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="grocery_model.User" %>

<%
    User adminUser = (User) request.getAttribute("adminUser");

    if (adminUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String successMsg = request.getParameter("successMsg");
    String errorMsg   = (String) request.getAttribute("errorMsg");
    String passError  = (String) request.getAttribute("passError");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Profile - FreshMart</title>

    <!-- Existing Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

    <!-- Profile CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminProfile.css">
</head>

<body>

<div class="admin-wrapper">

    <!-- Sidebar -->
    <div class="sidebar">

        <div class="sidebar-logo">
            <span>🛒</span>
            <p>FreshMart</p>
        </div>

        <nav class="sidebar-nav">

            <a href="${pageContext.request.contextPath}/adminDashboard" class="nav-item">
                <span class="nav-icon">🏠</span>
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/inventory" class="nav-item">
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

            <a href="${pageContext.request.contextPath}/adminProfile" class="nav-item active">
                <span class="nav-icon">👤</span>
                <span>My Profile</span>
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                <span class="nav-icon">🚪</span>
                <span>Logout</span>
            </a>

        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <div class="profile-wrapper">

            <% if (successMsg != null && !successMsg.isEmpty()) { %>
                <div class="alert-success">
                    ✓ <%= successMsg %>
                </div>
            <% } %>

            <!-- Profile Card -->
            <div class="profile-card profile-top-card">

                <div class="avatar-circle">
                    <%= adminUser.getFullName() != null
                        ? adminUser.getFullName().substring(0,1).toUpperCase()
                        : "A" %>
                </div>

                <div class="profile-name">
                    <%= adminUser.getFullName() %>
                </div>

                <div class="badge-wrap">
                    <span class="role-badge">ADMIN</span>
                </div>

                <div class="profile-email">
                    <%= adminUser.getEmail() %>
                </div>

            </div>

            <!-- Edit Profile -->
            <div class="profile-card">

                <div class="section-title">
                    ✏️ Edit Profile
                </div>

                <% if (errorMsg != null) { %>
                    <div class="alert-error">
                        ✗ <%= errorMsg %>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/adminProfile" method="post">

                    <div class="form-group">
                        <label>Full Name</label>

                        <input
                            type="text"
                            name="fullName"
                            value="<%= adminUser.getFullName() != null ? adminUser.getFullName() : "" %>"
                            required
                        />
                    </div>

                    <div class="form-group">
                        <label>Email</label>

                        <input
                            type="email"
                            value="<%= adminUser.getEmail() %>"
                            readonly
                        />
                    </div>

                    <div class="form-group">
                        <label>Phone</label>

                        <input
                            type="text"
                            name="phone"
                            value="<%= adminUser.getPhone() != null ? adminUser.getPhone() : "" %>"
                            placeholder="Phone number"
                        />
                    </div>

                    <button type="submit" class="btn-primary">
                        Save Changes
                    </button>

                </form>
            </div>

            <!-- Change Password -->
            <div class="profile-card">

                <div class="section-title">
                    🔒 Change Password
                </div>

                <% if (passError != null) { %>
                    <div class="alert-error">
                        ✗ <%= passError %>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/adminProfile" method="post">

                    <input type="hidden" name="action" value="changePassword"/>

                    <div class="form-group">
                        <label>Current Password</label>

                        <input
                            type="password"
                            name="currentPassword"
                            placeholder="Current password"
                            required
                        />
                    </div>

                    <div class="form-group">
                        <label>New Password</label>

                        <input
                            type="password"
                            name="newPassword"
                            placeholder="New password (min 6 chars)"
                            required
                        />
                    </div>

                    <div class="form-group">
                        <label>Confirm New Password</label>

                        <input
                            type="password"
                            name="confirmPassword"
                            placeholder="Confirm password"
                            required
                        />
                    </div>

                    <button type="submit" class="btn-warning">
                        Change Password
                    </button>

                </form>

            </div>

        </div>
    </div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="grocery_model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String successMsg = request.getParameter("successMsg");
    String errorMsg   = (String) request.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - FreshMart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <a href="<%= request.getContextPath() %>/home">&#8592; Back</a>
    <h1>FreshMart</h1>
    <span></span>
</nav>

<div class="page-wrapper">

    <h2 class="page-title">My Profile</h2>

    <!-- Success / Error messages -->
    <% if (successMsg != null && !successMsg.isEmpty()) { %>
        <div class="alert alert-success">&#10003; <%= successMsg %></div>
    <% } %>
    <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
        <div class="alert alert-error">&#10007; <%= errorMsg %></div>
    <% } %>

    <!-- Avatar card -->
    <div class="avatar-card">
        <div class="avatar-circle">
            <%= user.getFullName() != null ? user.getFullName().substring(0,1).toUpperCase() : "?" %>
        </div>
        <div class="avatar-label">Profile Photo</div>
        <div class="role-badge"><%= user.getRole().toUpperCase() %></div>
    </div>

    <!-- ══ VIEW MODE ══ -->
    <div id="viewMode">
        <div class="info-card">

            <div class="info-row">
                <div class="info-row-left">
                    <label>Name</label>
                    <span><%= user.getFullName() != null ? user.getFullName() : "" %></span>
                </div>
                <span class="chevron">&#8250;</span>
            </div>

            <div class="info-row">
                <div class="info-row-left">
                    <label>Email</label>
                    <span><%= user.getEmail() != null ? user.getEmail() : "" %></span>
                </div>
                <span class="chevron">&#8250;</span>
            </div>

            <div class="info-row">
                <div class="info-row-left">
                    <label>Phone</label>
                    <span class="<%= (user.getPhone() == null || user.getPhone().isEmpty()) ? "empty" : "" %>">
                        <%= (user.getPhone() != null && !user.getPhone().isEmpty()) ? user.getPhone() : "Not set" %>
                    </span>
                </div>
                <span class="chevron">&#8250;</span>
            </div>

            <div class="info-row">
                <div class="info-row-left">
                    <label>Address</label>
                    <span class="<%= (user.getAddress() == null || user.getAddress().isEmpty()) ? "empty" : "" %>">
                        <%= (user.getAddress() != null && !user.getAddress().isEmpty()) ? user.getAddress() : "Not set" %>
                    </span>
                </div>
                <span class="chevron">&#8250;</span>
            </div>

        </div>

        <!-- Edit Profile button -->
        <button class="btn-edit" onclick="toggleEdit(true)">Edit Profile</button>

        <!-- Logout -->
        <a href="<%= request.getContextPath() %>/logout" class="btn-logout">Log Out</a>
    </div>

    <!-- ══ EDIT MODE ══ -->
    <div id="editMode" class="edit-form">
        <form action="<%= request.getContextPath() %>/profile" method="post">
            <div class="form-card">

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="fullName"
                           value="<%= user.getFullName() != null ? user.getFullName() : "" %>"
                           placeholder="Your full name" required/>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email"
                           value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                           readonly/>
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="phone"
                           value="<%= user.getPhone() != null ? user.getPhone() : "" %>"
                           placeholder="Your phone number"/>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address"
                           value="<%= user.getAddress() != null ? user.getAddress() : "" %>"
                           placeholder="Your address"/>
                </div>

            </div>

            <button type="submit" class="btn-primary">Save Changes</button>
            <button type="button" class="btn-outline" onclick="toggleEdit(false)">Cancel</button>
        </form>
        
       </div>
       
      

    <!-- ══ CHANGE PASSWORD SECTION ══ -->
<div class="profile-section" style="margin-top: 15px;">
    
    <button class="btn-edit" onclick="togglePasswordForm()" id="changePassBtn">
        Change Password
    </button>

    <div id="changePasswordForm" style="display:none; margin-top: 20px;">
        
        <!-- Error message -->
        <% if (request.getAttribute("passError") != null) { %>
            <div class="alert alert-error">&#10007; <%= request.getAttribute("passError") %></div>
        <% } %>
        <!-- Success message -->
        <% if (successMsg != null && !successMsg.isEmpty() && successMsg.contains("Password")) { %>
            <div class="alert alert-success">&#10003; <%= successMsg %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/profile" method="post">
            <input type="hidden" name="action" value="changePassword"/>
            
            <div class="form-card">
                <div class="form-group">
                    <label>Current Password</label>
                    <input type="password" name="currentPassword"
                           placeholder="Recent password" required/>
                </div>
                <div class="form-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword"
                           placeholder="New password (min 6 chars)" required/>
                </div>
                <div class="form-group">
                    <label>Confirm New Password</label>
                    <input type="password" name="confirmPassword"
                           placeholder="Retype new password" required/>
                </div>
            </div>

            <button type="submit" class="btn-primary">Save New Password</button>
            <button type="button" class="btn-outline" onclick="togglePasswordForm()">Cancel</button>
        </form>
    </div>
  </div>
 </div> 

<script>
    function toggleEdit(show) {
        document.getElementById('viewMode').style.display = show ? 'none' : 'block';
        document.getElementById('editMode').classList.toggle('active', show);
    }

    <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
        toggleEdit(true);
    <% } %>
    
    
    function togglePasswordForm() {
        var form = document.getElementById('changePasswordForm');
        var btn  = document.getElementById('changePassBtn');
        if (form.style.display === 'none') {
            form.style.display = 'block';
            btn.textContent = 'Cancel';
        } else {
            form.style.display = 'none';
            btn.textContent = 'Change Password';
        }
    }
    
 // passError aayo bhane auto-open garnus
    <% if (request.getAttribute("passError") != null) { %>
        document.addEventListener("DOMContentLoaded", function() {
            togglePasswordForm();
        });
    <% } %>
    
    
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product - FreshMart Admin</title>
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
            <a href="${pageContext.request.contextPath}/adminDashboard" class="nav-item">
                <span class="nav-icon">🏠</span>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/inventory" class="nav-item">
                <span class="nav-icon">📦</span>
                <span>Inventory</span>
            </a>
            <a href="${pageContext.request.contextPath}/addProduct" class="nav-item active">
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
    <!-- ===================== END SIDEBAR ===================== -->

    <!-- ===================== MAIN CONTENT ===================== -->
    <div class="main-content">

        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-left">
                <h2>Add Product</h2>
                <p class="breadcrumb">Fill in the details to add a new product.</p>
            </div>
            <div class="topbar-right">
                <a href="${pageContext.request.contextPath}/inventory" class="btn-outline">
                    📦 Go to Inventory List
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

        <!-- ── ADD PRODUCT FORM ── -->
        <div class="form-card">

            <%-- multipart/form-data needed for file upload --%>
           <form action="${pageContext.request.contextPath}/addProduct"
      		method="post"
      		enctype="multipart/form-data">

                <!-- ROW 1: Product Name + Brand -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Product Name <span class="required">*</span></label>
                        <input type="text"
                               id="name"
                               name="name"
                               placeholder="Enter product name"
                               value="${param.name}"
                               required>
                    </div>
                    <div class="form-group">
                        <label for="brand">Brand <span class="required">*</span></label>
                        <input type="text"
                               id="brand"
                               name="brand"
                               placeholder="Enter product brand"
                               value="${param.brand}"
                               required>
                    </div>
                </div>

                <!-- ROW 2: Price + Stock Quantity -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">Price (Rs.) <span class="required">*</span></label>
                        <input type="number"
                               id="price"
                               name="price"
                               placeholder="0.00"
                               step="0.01"
                               min="0"
                               value="${param.price}"
                               required>
                    </div>
                    <div class="form-group">
                        <label for="stockQuantity">Stock Quantity <span class="required">*</span></label>
                        <input type="number"
                               id="stockQuantity"
                               name="stockQuantity"
                               placeholder="0"
                               min="0"
                               value="${param.stockQuantity}"
                               required>
                    </div>
                </div>

                <!-- ROW 3: Unit + Expiry Date -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="unit">Unit <span class="required">*</span></label>
                        <select id="unit" name="unit" required>
                            <option value="">-- Select Unit --</option>
                            <option value="kg"     ${param.unit == 'kg'     ? 'selected' : ''}>kg</option>
                            <option value="gram"   ${param.unit == 'gram'   ? 'selected' : ''}>gram</option>
                            <option value="litre"  ${param.unit == 'litre'  ? 'selected' : ''}>litre</option>
                            <option value="piece"  ${param.unit == 'piece'  ? 'selected' : ''}>piece</option>
                            <option value="dozen"  ${param.unit == 'dozen'  ? 'selected' : ''}>dozen</option>
                            <option value="bottle" ${param.unit == 'bottle' ? 'selected' : ''}>bottle</option>
                            <option value="pack"   ${param.unit == 'pack'   ? 'selected' : ''}>pack</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="expiryDate">Expiry Date</label>
                        <input type="date"
                               id="expiryDate"
                               name="expiryDate"
                               value="${param.expiryDate}">
                    </div>
                </div>

                <!-- ROW 4: Category (full width dropdown) -->
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="categoryId">Category <span class="required">*</span></label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">Select Category</option>
                            <%-- categoryList loaded by AddProductServlet (GET) --%>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.categoryId}"
                                    ${param.categoryId == cat.categoryId ? 'selected' : ''}>
                                    ${cat.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- ROW 5: Product Image (full width file upload) -->
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="imageFile">Product Image</label>
                        <input type="file"
                               id="imageFile"
                               name="imageFile"
                               accept="image/*"
                               class="file-input">
                        <p class="field-hint">Accepted: JPG, PNG, GIF. Max size: 2MB</p>
                    </div>
                </div>

                <!-- ROW 6: Description (full width textarea) -->
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="description">Description</label>
                        <textarea id="description"
                                  name="description"
                                  rows="4"
                                  placeholder="Enter product description">${param.description}</textarea>
                    </div>
                </div>

                <!-- SUBMIT BUTTONS -->
                <div class="form-actions">
                    <button type="submit" class="btn-submit">✅ Add Product</button>
                    <button type="reset"  class="btn-reset">🔄 Reset</button>
                </div>

            </form>
        </div>
        <!-- ── END FORM ── -->

    </div>
    <!-- ===================== END MAIN CONTENT ===================== -->

</div>

</body>
</html>

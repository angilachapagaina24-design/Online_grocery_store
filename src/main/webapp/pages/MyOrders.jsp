<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f5f5f5; padding-top: 70px; }

        .page-wrapper { max-width: 900px; margin: 40px auto; padding: 0 20px 60px; }

        h2 { color: #2e7d32; margin-bottom: 24px; }

        /* ── ORDER CARD ── */
        .order-card {
            background: #fff;
            border-radius: 12px;
            margin-bottom: 18px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            overflow: hidden;
        }

        /* ── CARD HEADER — click garda expand ── */
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 28px;
            cursor: pointer;
            transition: background 0.15s;
        }
        .order-header:hover { background: #fafafa; }

        .order-info h4 { margin: 0 0 5px; font-size: 16px; color: #333; }
        .order-info p  { margin: 0; color: #777; font-size: 13px; }

        .order-right { display: flex; flex-direction: column; align-items: flex-end; gap: 8px; }
        .order-amount { font-size: 18px; font-weight: 700; color: #2e7d32; }

        .toggle-icon {
            font-size: 13px;
            color: #aaa;
            margin-top: 4px;
        }

        /* ── BADGE ── */
        .badge {
            display: inline-block; padding: 4px 12px; border-radius: 20px;
            font-size: 12px; font-weight: 600; text-transform: capitalize;
        }
        .badge-pending    { background: #fff3e0; color: #e65100; }
        .badge-confirmed  { background: #e8f5e9; color: #2e7d32; }
        .badge-processing { background: #e3f2fd; color: #1565c0; }
        .badge-shipped    { background: #f3e5f5; color: #6a1b9a; }
        .badge-delivered  { background: #e8f5e9; color: #1b5e20; }
        .badge-cancelled  { background: #ffebee; color: #c62828; }

        /* ── ITEMS SECTION (hidden by default) ── */
        .order-items {
            display: none;
            border-top: 1px solid #f0f0f0;
            padding: 0 28px 20px;
            animation: fadeIn 0.2s ease;
        }
        .order-items.open { display: block; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-6px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ── ITEMS TABLE ── */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
            font-size: 14px;
        }
        .items-table thead tr {
            background: #f5f5f5;
            border-radius: 8px;
        }
        .items-table th {
            padding: 10px 14px;
            text-align: left;
            color: #888;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .items-table td {
            padding: 12px 14px;
            border-bottom: 1px solid #f5f5f5;
            color: #444;
        }
        .items-table tr:last-child td { border-bottom: none; }

        .item-name { font-weight: 600; color: #333; }
        .subtotal   { font-weight: 600; color: #2e7d32; }

        /* ── DELIVERY INFO ── */
        .delivery-info {
            margin-top: 14px;
            padding: 12px 14px;
            background: #f9f9f9;
            border-radius: 8px;
            font-size: 13px;
            color: #666;
        }
        .delivery-info span { font-weight: 600; color: #444; }

        /* ── EMPTY ── */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 16px; }
        .btn-shop {
            display: inline-block; margin-top: 16px; background: #2e7d32;
            color: #fff; padding: 12px 28px; border-radius: 8px;
            text-decoration: none; font-weight: 600;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="page-wrapper">
    <h2>My Orders</h2>

    <c:choose>
        <c:when test="${not empty orderList}">
            <c:forEach var="order" items="${orderList}" varStatus="loop">

                <div class="order-card">

                    <!-- Header — click garda items dekhaucha -->
                    <div class="order-header" onclick="toggleItems('items-${order.orderId}', 'icon-${order.orderId}')">

                        <div class="order-info">
                            <h4>Order #${order.orderId}</h4>
                            <p>
                                📅 ${order.createdAt}
                                &nbsp;|&nbsp;
                                💳 ${order.paymentMethod}
                            </p>
                            <br/>
                            <span class="badge badge-${order.orderStatus}">${order.orderStatus}</span>
                        </div>

                        <div class="order-right">
                            <div class="order-amount">
                                Rs. <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2"/>
                            </div>
                            <div class="toggle-icon" id="icon-${order.orderId}">
                                ▼ View Items
                            </div>
                        </div>

                    </div>

                    <!-- Items Section -->
                    <div class="order-items" id="items-${order.orderId}">

                        <c:choose>
                            <c:when test="${not empty order.items}">
                                <table class="items-table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Product</th>
                                            <th>Price</th>
                                            <th>Qty</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${order.items}" varStatus="iLoop">
                                            <tr>
                                                <td>${iLoop.count}</td>
                                                <td class="item-name">${item.productName}</td>
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
                                <p style="color:#aaa; padding: 12px 0; font-size:13px;">
                                    Items details available xaina.
                                </p>
                            </c:otherwise>
                        </c:choose>

                        <!-- Delivery Address -->
                        <c:if test="${not empty order.shippingAddress}">
                            <div class="delivery-info">
                                📦 Delivery Address: <span>${order.shippingAddress}</span>
                            </div>
                        </c:if>

                    </div>
                </div>

            </c:forEach>
        </c:when>

        <c:otherwise>
            <div class="empty-msg">
                <p>You haven't placed any orders yet.</p>
                <a href="${pageContext.request.contextPath}/product" class="btn-shop">Start Shopping</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="Footer.jsp"/>

<script>
    function toggleItems(itemsId, iconId) {
        var items = document.getElementById(itemsId);
        var icon  = document.getElementById(iconId);

        if (items.classList.contains('open')) {
            items.classList.remove('open');
            icon.innerHTML = '▼ View Items';
        } else {
            items.classList.add('open');
            icon.innerHTML = '▲ Hide Items';
        }
    }
</script>

</body>
</html>

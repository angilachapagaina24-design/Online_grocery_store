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
        .page-wrapper { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        h2 { color: #2e7d32; margin-bottom: 24px; }
        .order-card {
            background: #fff; border-radius: 12px; padding: 24px 28px;
            margin-bottom: 18px; box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            display: flex; justify-content: space-between; align-items: center;
        }
        .order-info h4 { margin: 0 0 6px; font-size: 16px; color: #333; }
        .order-info p  { margin: 0; color: #777; font-size: 14px; }
        .order-amount  { font-size: 18px; font-weight: 700; color: #2e7d32; }
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
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 16px; }
        .btn-shop {
            display: inline-block; margin-top: 16px; background: #2e7d32;
            color: #fff; padding: 12px 28px; border-radius: 8px; text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="page-wrapper">
    <h2>My Orders</h2>

    <c:choose>
        <c:when test="${not empty orderList}">
            <c:forEach var="order" items="${orderList}">
                <div class="order-card">
                    <div class="order-info">
                        <h4>Order #${order.orderId}</h4>
                        <p>Payment: ${order.paymentMethod} &nbsp;|&nbsp; Date: ${order.createdAt}</p>
                        <br>
                        <span class="badge badge-${order.orderStatus}">${order.orderStatus}</span>
                    </div>
                    <div class="order-amount">
                        Rs. <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2"/>
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
</body>
</html>

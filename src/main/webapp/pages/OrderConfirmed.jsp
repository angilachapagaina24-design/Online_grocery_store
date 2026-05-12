<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmed - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f5f5f5; padding-top: 70px; }
        .success-wrapper {
            display: flex; align-items: center; justify-content: center;
            min-height: calc(100vh - 140px);
        }
        .success-box {
            background: white; padding: 50px 60px; border-radius: 20px;
            text-align: center; box-shadow: 0 4px 20px rgba(0,0,0,0.10);
            max-width: 480px; width: 100%;
        }
        .tick-circle {
            width: 80px; height: 80px; background: #e8f5e9; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px; font-size: 40px;
        }
        h1 { color: #2e7d32; margin: 0 0 10px; font-size: 26px; }
        .order-id { background: #f1f8e9; border: 1px dashed #aed581; border-radius: 10px;
            padding: 12px 24px; margin: 20px auto; font-size: 18px; font-weight: 700;
            color: #33691e; display: inline-block; }
        p { color: #666; margin: 6px 0; }
        .btn-home {
            display: inline-block; margin-top: 24px; background: #ff7011;
            color: white; padding: 12px 32px; border-radius: 10px;
            text-decoration: none; font-weight: 600; font-size: 15px;
            transition: background 0.2s;
        }
        .btn-home:hover { background: #e65100; }
        .btn-orders {
            display: inline-block; margin-top: 12px; background: #f5f5f5;
            color: #333; padding: 10px 24px; border-radius: 10px;
            text-decoration: none; font-size: 14px; margin-left: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="success-wrapper">
    <div class="success-box">
        <div class="tick-circle">✅</div>
        <h1>Order Placed!</h1>
        <p>Thank you for shopping with FreshMart.</p>
        <p>Your order has been received and is being processed.</p>
        <div class="order-id">Order #<%= request.getParameter("orderId") %></div>
        <br>
        <a href="<%= request.getContextPath() %>/home" class="btn-home">Continue Shopping</a>
        <a href="<%= request.getContextPath() %>/myOrders" class="btn-orders">View My Orders</a>
    </div>
</div>

<jsp:include page="Footer.jsp"/>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean showPopup = (Boolean) request.getAttribute("showPopup");
    boolean popup = (showPopup != null && showPopup);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us | FreshMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --main-green: #2d6a4f;
            --light-bg:   #f9f7f2;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--light-bg);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* ── Card ── */
        .contact-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            display: flex;
            gap: 50px;
            max-width: 900px;
            width: 90%;
        }

        .form-side { flex: 1.5; }

        .info-side {
            flex: 1;
            border-left: 1px solid #eee;
            padding-left: 40px;
        }

        /* ── Typography ── */
        h2 { color: #333; margin-bottom: 6px; }
        h3 { margin: 20px 0 12px; color: #333; }
        p  { color: #666; font-size: 14px; margin-bottom: 16px; }

        /* ── Inputs ── */
        .input-box {
            width: 100%;
            padding: 12px 14px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: inherit;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .input-box:focus { border-color: var(--main-green); }
        textarea.input-box { height: 120px; resize: none; }

        /* ── Button ── */
        .send-btn {
            background: var(--main-green);
            color: white;
            border: none;
            width: 100%;
            padding: 15px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            margin-top: 6px;
            transition: background 0.3s;
        }
        .send-btn:hover { background: #1b4332; }

        /* ── Info side ── */
        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
            color: #444;
            font-size: 14px;
        }
        .info-item i {
            color: #d62828;
            margin-right: 14px;
            font-size: 18px;
            width: 20px;
            text-align: center;
        }
        .social-icons { margin-top: 8px; }
        .social-icons i {
            font-size: 24px;
            color: #ccc;
            margin-right: 14px;
            cursor: pointer;
            transition: color 0.2s;
        }
        .social-icons i:hover { color: var(--main-green); }

        /* ── Modal ── */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.45);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }
        .modal-overlay.active { display: flex; }

        .modal-box {
            background: white;
            border-radius: 16px;
            padding: 40px 36px;
            text-align: center;
            max-width: 360px;
            width: 88%;
            box-shadow: 0 12px 40px rgba(0,0,0,0.12);
            animation: popIn 0.25s ease;
        }
        @keyframes popIn {
            from { transform: scale(0.85); opacity: 0; }
            to   { transform: scale(1);    opacity: 1; }
        }
        .modal-icon i { font-size: 56px; color: var(--main-green); }
        .modal-box h3 { margin: 16px 0 8px; font-size: 22px; color: #222; }
        .modal-box p  { font-size: 14px; color: #666; line-height: 1.6; margin: 0 0 24px; }

        .modal-close-btn {
            background: var(--main-green);
            color: white;
            border: none;
            padding: 12px 36px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        .modal-close-btn:hover { background: #1b4332; }

        /* ── Responsive ── */
        @media (max-width: 650px) {
            .contact-card  { flex-direction: column; gap: 30px; padding: 24px; }
            .info-side     { border-left: none; border-top: 1px solid #eee; padding-left: 0; padding-top: 24px; }
        }
    </style>
</head>
<body>

<div class="contact-card">

    <!-- Left: Form -->
    <div class="form-side">
        <h2>Contact Us</h2>
        <p>We'd love to hear from you!</p>

        <form method="POST" action="${pageContext.request.contextPath}/ContactServlet">
            <input   type="text"  name="name"    class="input-box" placeholder="Your Name"    required>
            <input   type="email" name="email"   class="input-box" placeholder="Your Email"   required>
            <input   type="text"  name="subject" class="input-box" placeholder="Subject">
            <textarea             name="message" class="input-box" placeholder="Your Message" required></textarea>
            <button  type="submit" class="send-btn">Send Message</button>
        </form>
    </div>

    <!-- Right: Store Info -->
    <div class="info-side">
        <h3 style="color: var(--main-green);">Store Info</h3>
        <div class="info-item"><i class="fas fa-map-marker-alt"></i> Pokhara, Nepal</div>
        <div class="info-item"><i class="fas fa-phone"></i> +977-9800000000</div>
        <div class="info-item"><i class="fas fa-envelope"></i> freshmart@gmail.com</div>
        <h3>Follow Us</h3>
        <div class="social-icons">
            <i class="fab fa-facebook"></i>
            <i class="fab fa-instagram"></i>
            <i class="fab fa-twitter"></i>
        </div>
    </div>
</div>

<!-- SUCCESS POPUP -->
<div class="modal-overlay" id="successModal">
    <div class="modal-box">
        <div class="modal-icon"><i class="fas fa-check-circle"></i></div>
        <h3>Message Sent!</h3>
        <p>Thank you for reaching out.<br>We'll get back to you soon.</p>
        <button class="modal-close-btn" onclick="closeModal()">Done</button>
    </div>
</div>

<script>
    if (<%= popup %>) {
        document.getElementById('successModal').classList.add('active');
    }
    function closeModal() {
        document.getElementById('successModal').classList.remove('active');
    }
    document.getElementById('successModal').addEventListener('click', function(e) {
        if (e.target === this) closeModal();
    });
</script>

</body>
</html>
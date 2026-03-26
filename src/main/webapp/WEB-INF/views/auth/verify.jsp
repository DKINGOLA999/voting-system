<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/fragment/head.jsp" %>
<title>Verify - Votify</title>

<style>
body{
    font-family:'Segoe UI',sans-serif;
    background: linear-gradient(135deg,#0a1f44,#000000);
}

.hero{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.card-box{
    background:white;
    padding:40px;
    border-radius:15px;
    max-width:400px;
    width:100%;
    box-shadow:0 20px 60px rgba(0,0,0,0.5);
}

.btn-main{
    background:#0a1f44;
    color:white;
}
</style>
</head>

<body>
<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

<div class="hero">
<div class="card-box text-center">

<h3>Verify Your Email</h3>
<p style="color:#555;">Enter the OTP sent to your email.</p>

<form action="verifyOtp" method="post">

    <input type="text" name="otp" class="form-control mb-3" placeholder="Enter OTP" required>

    <input type="hidden" name="email"
    value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>

    <button class="btn btn-main w-100">Verify</button>

</form>

<div class="mt-3">
    <form action="<%= request.getContextPath() %>/resendOtp" method="post" style="display: inline;">
        <input type="hidden" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
        <button type="submit" class="btn btn-link p-0">Didn't receive OTP? Resend</button>
    </form>
</div>

</div>
</div>

<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>

</body>
</html>
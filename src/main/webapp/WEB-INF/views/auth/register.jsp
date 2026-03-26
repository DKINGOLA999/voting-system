<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/fragment/head.jsp" %>
<title>Register - Votify</title>

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
    padding:40px;
}

.card-box{
    background:white;
    padding:40px;
    border-radius:15px;
    max-width:650px;
    width:100%;
    box-shadow:0 20px 60px rgba(0,0,0,0.5);
}

.section h3{
    color:#0a1f44;
}

.btn-main{
    background:#0a1f44;
    color:white;
    border-radius:25px;
}
</style>
</head>

<body>
<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

<div class="hero">
<div class="card-box">

    <div class="section text-center">
        <h3>Create Account</h3>
        <p style="color:#555;">Register to participate in secure elections.</p>
    </div>

    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="register" method="post">

        <div class="row mb-3">
            <div class="col-md-6">
                <input type="text" name="firstName" class="form-control" placeholder="First Name" required>
            </div>
            <div class="col-md-6">
                <input type="text" name="lastName" class="form-control" placeholder="Last Name" required>
            </div>
        </div>

        <input type="email" name="email" class="form-control mb-3" placeholder="Email Address" required>

        <div class="row mb-3">
            <div class="col-md-6">
                <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
            </div>
            <div class="col-md-6">
                <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
            </div>
        </div>

        <input type="date" name="birthDate" class="form-control mb-3" required>

        <div class="row mb-3">
            <div class="col-md-6">
                <input type="text" name="state" class="form-control" placeholder="State" required>
            </div>
            <div class="col-md-6">
                <input type="text" name="country" class="form-control" placeholder="Country" required>
            </div>
        </div>

        <button class="btn btn-main w-100">Register</button>

    </form>

    <div class="text-center mt-3">
        <small>Already have an account? <a href="login">Login</a></small>
    </div>

</div>
</div>

<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>

</body>
</html>
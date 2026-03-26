<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/fragment/head.jsp" %>
<title>Login - Votify</title>

<style>
body{
    font-family:'Segoe UI',sans-serif;
    background: linear-gradient(135deg,#0a1f44,#000000);
}

.hero{
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:40px;
}

.card-box{
    background:rgba(255,255,255,0.96);
    border-radius:15px;
    padding:40px;
    width:100%;
    max-width:500px;
    box-shadow:0 20px 60px rgba(0,0,0,0.5);
    transition:0.4s;
}

.card-box:hover{
    transform:translateY(-5px);
}

.section h3{
    color:#0a1f44;
    margin-bottom:15px;
}

.btn-main{
    background:#0a1f44;
    color:white;
    border-radius:25px;
    transition:0.3s;
}

.btn-main:hover{
    background:black;
}
</style>
</head>

<body>
<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

<div class="hero">
<div class="card-box">

    <div class="section text-center">
        <h3>Login to Votify</h3>
        <p style="color:#555;">Access your account securely.</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="login" method="post">

        <div class="mb-3">
            <label>Email Address</label>
            <input type="email" name="email" class="form-control" required
            value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
        </div>

        <div class="mb-3">
            <label>Password</label>
            <div class="input-group">
                <input type="password" name="password" id="password" class="form-control" required>
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password')">
                    👁️
                </button>
            </div>
        </div>

        <button class="btn btn-main w-100">Login</button>
    </form>

    <div class="text-center mt-3">
        <small>Don't have an account? <a href="register">Create Account</a></small><br>
        <a href="forgotPassword">Forgot Password?</a>
    </div>

</div>
</div>

<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>

<script>
function togglePassword(id){
    let field=document.getElementById(id);
    field.type = field.type==="password" ? "text" : "password";
}
</script>

</body>
</html>
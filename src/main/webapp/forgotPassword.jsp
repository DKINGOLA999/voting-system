<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>
    <title>Forgot Password - Votify</title>
</head>
<body>
<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card p-4 shadow-sm">
                <h4 class="text-center mb-3">Forgot Password</h4>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="forgotPassword" method="post">
                    <input type="email" name="email" class="form-control mb-3" placeholder="Enter your email address" required>
                    <button class="btn btn-primary w-100">Send Reset Code</button>
                </form>

                <div class="mt-3 text-center">
                    <a href="login" class="btn btn-link p-0">Back to Login</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>

</body>
</html>

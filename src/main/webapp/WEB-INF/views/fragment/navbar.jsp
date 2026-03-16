<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

<div class="container">

<a class="navbar-brand"
href="<%=request.getContextPath()%>/">
Voting System
</a>

<button class="navbar-toggler"
type="button"
data-bs-toggle="collapse"
data-bs-target="#navbarNav">

<span class="navbar-toggler-icon"></span>

</button>

<div class="collapse navbar-collapse"
id="navbarNav">

<ul class="navbar-nav ms-auto">

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/">
Home
</a>
</li>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/about">
About
</a>
</li>

<%
Object user = session.getAttribute("user");

if(user != null){
%>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/voter/dashboard">
Dashboard
</a>
</li>

<li class="nav-item">
<a class="nav-link text-danger"
href="<%=request.getContextPath()%>/logout">
Logout
</a>
</li>

<%
}else{
%>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/login">
Login
</a>
</li>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/register">
Register
</a>
</li>

<%
}
%>

</ul>

</div>
</div>
</nav>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Vote"%>

<!DOCTYPE html>
<html>
<head> 
<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/admin.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<div class="wrapper">

<!-- SIDEBAR -->

<div class="sidebar">

<div class="sidebar-header">

<div class="avatar">A</div>

<div>
<h3>Results</h3>
<span class="online">Online</span>
</div>

</div>

<ul class="menu">

<li>
<a href="<%=request.getContextPath()%>/admin?action=dashboard">
<i class="fa fa-chart-line"></i> Dashboard
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin?action=voters">
<i class="fa fa-users"></i> Voters
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin?action=contester">
<i class="fa fa-user-tie"></i> Contesters
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin?action=vote">
<i class="fa fa-check"></i> Votes
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin?action=user" class="active">
<i class="fa fa-user"></i> Users
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin?action=results">
<i class="fa fa-chart-pie"></i> Results
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin?action=settings">
<i class="fa fa-cog"></i> Settings
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/logout">
<i class="fa fa-sign-out"></i> Logout
</a>
</li>

</ul>

</div>


<div style="flex:1;padding:40px;">

<h2>Election Results</h2>

<p>Live election results overview</p>

<div style="display:grid;grid-template-columns:repeat(4,1fr);gap:20px;">

<div style="background:white;padding:20px;border-radius:10px;">
<h3>${presidentVotes}</h3>
<p>President Votes</p>
</div>

<div style="background:white;padding:20px;border-radius:10px;">
<h3>${viceVotes}</h3>
<p>Vice President Votes</p>
</div>

<div style="background:white;padding:20px;border-radius:10px;">
<h3>${secretaryVotes}</h3>
<p>Secretary Votes</p>
</div>

<div style="background:white;padding:20px;border-radius:10px;">
<h3>${treasurerVotes}</h3>
<p>Treasurer Votes</p>
</div>

</div>

</div>

</div>

</body>
</html>
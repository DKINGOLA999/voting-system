<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Vote"%>

<%
List<Vote> votes = (List<Vote>) request.getAttribute("votes");
%>

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
<h3>Votes</h3>
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
<a href="<%=request.getContextPath()%>/admin?action=result">
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

<!-- NAVBAR -->

<div style="flex:1;display:flex;flex-direction:column;">

<!-- NAVBAR -->

<div style="background:#0f172a;color:white;padding:18px 30px;
display:flex;justify-content:space-between;align-items:center;">

<div style="font-size:20px;font-weight:bold;">🗳 Voting Admin</div>

<div>

<a href="<%=request.getContextPath()%>/admin?action=dashboard"
style="color:#cbd5e1;margin-right:20px;text-decoration:none;">Dashboard</a>

<a href="<%=request.getContextPath()%>/logout"
style="border:1px solid #ef4444;padding:6px 14px;border-radius:20px;
color:white;text-decoration:none;">Logout</a>

</div>

</div>


<!-- CONTENT -->

<div style="flex:1;padding:40px;">

<div style="background:white;padding:25px;border-radius:10px;
box-shadow:0 5px 20px rgba(0,0,0,0.05);margin-bottom:30px;">

<h2>📦Vote Records</h2>

<p style="color:#64748b;">
Votes are counted and stored here precisely and respectfully🏬.
</p>

</div>


<!-- PAGE CONTAINER -->


<div style="
background:white;
border-radius:10px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);
overflow:hidden;
">

<table style="width:100%;border-collapse:collapse;">

<tr style="background:#1f2937;color:white;">
<th style="padding:14px;text-align:left;">Voter Email</th>
<th>Contester</th>
<th>Position</th>
</tr>

<%

if(votes == null || votes.isEmpty()){

%>

<tr>
<td colspan="3" style="text-align:center;padding:20px;color:#888;">
No votes recorded yet
</td>
</tr>

<%

}else{

for(Vote v : votes){

%>

<tr style="border-bottom:1px solid #eee;">

<td style="padding:14px;">
<%=v.getVoter().getEmail()%>
</td>

<td>
<%=v.getContester().getUser().getFirstName()%>
</td>

<td>
<%=v.getContester().getPosition()%>
</td>

</tr>

<%

}

}

%>

</table>

</div>
</div>

</div>
</div>
<div style="background:#111827;color:#9ca3af;text-align:center;padding:15px;">
Voting System Administration

</div>
</body>
</html>
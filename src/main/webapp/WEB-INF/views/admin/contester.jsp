<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Contester"%>

<%
List<Contester> contesters =
(List<Contester>) request.getAttribute("contesters");
%>

<!DOCTYPE html>
<html>

<head>
<title>Contesters</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/admin.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body style="margin:0;font-family:Arial;background:#f4f6f9;">

<div style="display:flex;min-height:100vh;">

<!-- SIDEBAR -->

<div class="sidebar">

<div class="sidebar-header">

<div class="avatar">A</div>

<div>
<h3>Contesters</h3>
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


<div style="flex:1;display:flex;flex-direction:column;">

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

<div style="flex:1;padding:40px;">

<div style="background:white;padding:25px;border-radius:10px;
box-shadow:0 5px 20px rgba(0,0,0,0.05);margin-bottom:30px;">

<h2>Contesters Records🏦</h2>

<p style="color:#64748b;">
Contesters registered for a fair online voting system.✅
</p>

</div>



<h2>Election Contesters</h2>

<table style="width:100%;background:white;border-collapse:collapse;
box-shadow:0 5px 20px rgba(0,0,0,0.05);">

<tr style="background:#1f2937;color:white;">
<th style="padding:14px;">Candidate</th>
<th>Position</th>
<th>Status</th>
<th>Reason</th>
<th>Action</th>
</tr>

<%
if(contesters == null || contesters.isEmpty()){
%>

<tr>
<td colspan="5" style="padding:20px;text-align:center;">No contesters</td>
</tr>

<%
}else{

for(Contester c : contesters){
%>

<tr style="border-bottom:1px solid #eee;">

<td style="padding:12px;"><%=c.getUser().getFirstName()%></td>

<td><%=c.getPosition()%></td>

<td><%=c.getStatus()%></td>

<td><%=c.getReason()%></td>

<td>

<a href="<%=request.getContextPath()%>/admin?action=approve&id=<%=c.getId()%>">

<button style="background:#22c55e;border:none;color:white;padding:6px 12px;border-radius:4px;">Approve</button>

</a>

<a href="<%=request.getContextPath()%>/admin?action=deny&id=<%=c.getId()%>">

<button style="background:#ef4444;border:none;color:white;padding:6px 12px;border-radius:4px;">Deny</button>

</a>

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
<div style="background:#111827;color:#9ca3af;text-align:center;padding:15px;">
Voting System Administration

</div>
</body>
</html>



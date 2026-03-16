<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Setting"%>

<%
Setting setting = (Setting) request.getAttribute("setting");
%>


<!DOCTYPE html>
<html>

<head>

<title>System Settings</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/admin.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap"
rel="stylesheet">

</head>

<body style="margin:0;font-family:Poppins;background:#f1f5f9;">

<div style="display:flex;min-height:100vh;">

<!-- SIDEBAR -->


<div class="sidebar">

<div class="sidebar-header">

<div class="avatar">A</div>

<div>
<h3>Settings</h3>
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


<!-- PAGE AREA -->

<div style="flex:1;display:flex;flex-direction:column;">


<!-- NAVBAR -->

<div style="background:#0f172a;color:white;padding:18px 30px;
display:flex;justify-content:space-between;align-items:center;">

<div style="font-size:20px;font-weight:600;">
⚙ System Settings
</div>

<div>

<a href="<%=request.getContextPath()%>/admin?action=dashboard"
style="color:#cbd5e1;margin-right:20px;text-decoration:none;">Dashboard</a>

<a href="<%=request.getContextPath()%>/logout"
style="border:1px solid #ef4444;padding:6px 14px;border-radius:20px;
color:white;text-decoration:none;">
Logout
</a>

</div>


</div>

<!-- CONTENT -->

<div style="flex:1;display:flex;align-items:center;justify-content:center;padding:40px;">


<div style="background:white;width:520px;padding:40px;border-radius:12px;
box-shadow:0 10px 30px rgba(0,0,0,0.08);
animation:fadeIn 0.6s ease;">


<h2 style="margin-top:0;">📅Election Configuration</h2>

<p style="color:#64748b;margin-bottom:30px;">
Configure election details and voting period.
</p>


<form action="<%=request.getContextPath()%>/admin" method="post">

<input type="hidden" name="action" value="saveSettings">


<div style="margin-bottom:20px;">

<label style="font-weight:500;">Election Name</label>

<input type="text"
name="electionName"
value="<%= setting != null ? setting.getElectionName() : "" %>"
placeholder="Student Government Election 2026"

style="width:100%;
padding:12px;
margin-top:6px;
border-radius:6px;
border:1px solid #d1d5db;
font-family:Poppins;">

</div>


<div style="margin-bottom:20px;">

<label style="font-weight:500;">Voting Start Date</label>

<input type="date"
name="startDate"
value="<%= setting != null ? setting.getStartDate() : "" %>"

style="width:100%;
padding:12px;
margin-top:6px;
border-radius:6px;
border:1px solid #d1d5db;">

</div>


<div style="margin-bottom:25px;">

<label style="font-weight:500;">Voting End Date</label>

<input type="date"
name="endDate"
value="<%= setting != null ? setting.getEndDate() : "" %>"

style="width:100%;
padding:12px;
margin-top:6px;
border-radius:6px;
border:1px solid #d1d5db;">

</div>


<button type="submit"

style="width:100%;
background:#2563eb;
color:white;
padding:12px;
border:none;
border-radius:8px;
font-size:15px;
font-weight:500;
cursor:pointer;
transition:0.3s;">

<i class="fa fa-save"></i> Save Settings

</button>

</form>
</div>

</div>

<!-- FOOTER -->

<div style="background:#111827;color:#9ca3af;text-align:center;padding:15px;">
Voting System Administration
</div>

</div>

</div>

<style>

@keyframes fadeIn{
from{opacity:0;transform:translateY(20px);}
to{opacity:1;transform:translateY(0);}
}

button:hover{
background:#1d4ed8;
}

input:focus{
outline:none;
border-color:#2563eb;
box-shadow:0 0 0 2px rgba(37,99,235,0.2);
}

</style>

</body>
</html>
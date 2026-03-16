<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Voter"%>

<%
List<Voter> voters = (List<Voter>) request.getAttribute("voters");

String adminName = (String) session.getAttribute("adminName");
if(adminName == null){
adminName = "Admin";
}

String avatarLetter = adminName.substring(0,1).toUpperCase();
%>

<!DOCTYPE html>
<html>
<head>

<title>Voting Admin Dashboard</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/admin.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<div class="wrapper">

<!-- SIDEBAR -->

<div class="sidebar">

<div class="sidebar-header">

<div class="avatar">
<%=avatarLetter%>
</div>

<div>
<h3><%=adminName%></h3>
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
<a href="<%=request.getContextPath()%>/admin?action=user">
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


<!-- MAIN -->

<div class="main">

<!-- TOP NAVBAR -->

<div class="topnav">

<div class="nav-links">

<a href="<%=request.getContextPath()%>/">Home</a>
<a href="#">About</a>
<a href="#">Contact</a>
<a href="#">Sign In</a>
<a href="#">Register</a>

</div>

<div class="top-icons">
<div class="icon-dropdown">

<i class="fa fa-bell"></i>

<div class="dropdown-box">

<p>No new notifications</p>

</div>

</div>


<div class="icon-dropdown">

<i class="fa fa-envelope"></i>

<div class="dropdown-box">

<p>No new messages</p>

</div>

</div>

<div class="avatar small">
<%=avatarLetter%>
</div>

</div>

</div>


<!-- DASHBOARD CONTENT -->

<div class="content">

<!-- STATS -->

<div class="stats">

<div class="card blue">
<h2>${totalUsers}</h2>
<p>Total Users</p>
</div>

<div class="card green">
<h2>${totalVoters}</h2>
<p>Voters</p>
</div>

<div class="card purple">
<h2>${totalContesters}</h2>
<p>Contesters</p>
</div>

<div class="card orange">
<h2>${totalVotes}</h2>
<p>Votes</p>
</div>

</div>

<div class="extra-stats">

<div class="extra-box">

<div class="extra-icon">
<i class="fa-solid fa-user-check"></i>
</div>

<h3>${verifiedVoters}</h3>

<p>Verified Voters</p>

<span>Eligible voters approved by admin</span>

</div>


<div class="extra-box">

<div class="extra-icon">
<i class="fa-solid fa-clock"></i>
</div>

<h3>${pendingVotes}</h3>

<p>Pending Vote Reviews</p>

<span>Votes awaiting verification</span>

</div>


<div class="extra-box">

<div class="extra-icon">
<i class="fa-solid fa-trophy"></i>
</div>

<h3>${leadingCandidate}</h3>

<p>Current Leading Candidate</p>

<span>Candidate with highest votes</span>

</div>

</div>

<!-- CHART -->

<div class="chart-box">

<h3>Election Vote Distribution</h3>

<canvas id="voteChart"></canvas>

</div>


<!-- VOTERS TABLE -->

<div class="table-box">

<h3>Registered Voters</h3>

<table>

<tr>
<th>Name</th>
<th>Email</th>
<th>Action</th>
</tr>

<%

if(voters == null || voters.isEmpty()){
%>

<tr>
<td colspan="3">No voters registered</td>
</tr>

<%
}else{

for(Voter v : voters){
%>

<tr>

<td><%=v.getName()%></td>

<td><%=v.getEmail()%></td>

<td>

<a class="delete"
href="admin?action=deleteVoter&id=<%=v.getId()%>">

Delete

</a>

</td>

</tr>

<%
}

}
%>

</table>

<script>

const ctx = document.getElementById('voteChart')

new Chart(ctx,{

type:'bar',

data:{
labels:['President','Vice President','Secretary','Treasurer'],

datasets:[{

label:'Votes',

data:[
${presidentVotes},
${viceVotes},
${secretaryVotes},
${treasurerVotes}
]

}]

}
})

 <!-- content -->
</script>

</div>


</div>
<div style="background:#111827;color:#9ca3af;text-align:center;padding:15px;">
<div style="
background:#0f172a;
color:#e2e8f0;
margin-top:60px;
padding:50px 40px;
font-family:'Segoe UI',sans-serif;
">

<div style="
display:grid;
grid-template-columns:repeat(4,1fr);
gap:40px;
max-width:1200px;
margin:auto;
">

<!-- COLUMN 1 -->
<div>

<h3 style="margin-bottom:10px;font-size:20px;color:white;">
🗳 Online Voting
</h3>

<p style="font-size:14px;color:#94a3b8;line-height:1.6;">
Secure and transparent digital election platform designed
to ensure fairness, privacy, and integrity in voting.
</p>

</div>


<!-- COLUMN 2 -->
<div>

<h4 style="margin-bottom:12px;font-size:16px;color:#cbd5f5;">
System
</h4>

<div style="display:flex;flex-direction:column;gap:8px;">

<a href="<%=request.getContextPath()%>/admin?action=dashboard"
style="color:#94a3b8;text-decoration:none;">Dashboard</a>

<a href="<%=request.getContextPath()%>/admin?action=voters"
style="color:#94a3b8;text-decoration:none;">Voters</a>

<a href="<%=request.getContextPath()%>/admin?action=contester"
style="color:#94a3b8;text-decoration:none;">Contesters</a>

<a href="<%=request.getContextPath()%>/admin?action=vote"
style="color:#94a3b8;text-decoration:none;">Vote Records</a>

</div>

</div>


<!-- COLUMN 3 -->
<div>

<h4 style="margin-bottom:12px;font-size:16px;color:#cbd5f5;">
Security
</h4>

<div style="display:flex;flex-direction:column;gap:8px;">

<a href="#"
style="color:#94a3b8;text-decoration:none;">Encrypted Votes</a>

<a href="#"
style="color:#94a3b8;text-decoration:none;">Identity Verification</a>

<a href="#"
style="color:#94a3b8;text-decoration:none;">Secure Login</a>

<a href="#"
style="color:#94a3b8;text-decoration:none;">Vote Tracking</a>

</div>

</div>


<!-- COLUMN 4 -->
<div>

<h4 style="margin-bottom:12px;font-size:16px;color:#cbd5f5;">
Status
</h4>

<p style="color:#22c55e;font-weight:bold;margin-bottom:6px;">
● System Running
</p>

<p style="color:#94a3b8;font-size:14px;">
Election Integrity Protected
</p>

</div>

</div>


<!-- COPYRIGHT -->

<div style="
text-align:center;
margin-top:40px;
font-size:14px;
color:#64748b;
border-top:1px solid #1e293b;
padding-top:20px;
">

© 2026 Online Voting System | Admin Panel

</div>
</div>


</body>
</html>




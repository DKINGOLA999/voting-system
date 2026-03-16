<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.User"%>

<%
List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>

<head>

<title>User Records</title>

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
<h3>Users</h3>
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

<h2>👤User Records</h2>

<p style="color:#64748b;">
Users registered but not participating as voters.📑✔️
</p>

</div>


<div style="background:white;border-radius:10px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);overflow:hidden;">

<table style="width:100%;border-collapse:collapse;">

<tr style="background:#1f2937;color:white;">
<th style="padding:14px;">First Name</th>
<th>Last Name</th>
<th>Email</th>
</tr>

<%
if(users == null || users.isEmpty()){
%>

<tr>
<td colspan="3" style="text-align:center;padding:20px;color:#888;">
No users recorded yet
</td>
</tr>

<%
}else{

for(User u : users){
%>

<tr style="border-bottom:1px solid #eee;">

<td style="padding:14px;"><%=u.getFirstName()%></td>

<td><%=u.getLastName()%></td>

<td><%=u.getEmail()%></td>

</tr>

<%
}
}
%>

</table>

</div>

</div>


<!-- FOOTER -->

<div>
<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</div>

</div>

</div>

</body>
</html>

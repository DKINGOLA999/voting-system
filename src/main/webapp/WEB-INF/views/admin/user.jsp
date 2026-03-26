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

<style>
    /* THE ABSOLUTE MODAL STYLING */
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(15, 23, 42, 0.8);
        backdrop-filter: blur(8px);
        z-index: 9999;
        justify-content: center;
        align-items: center;
    }

    .modal-box {
        background: white;
        width: 550px;
        border-radius: 20px;
        padding: 40px;
        position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        animation: modalFadeIn 0.3s ease-out;
    }

    @keyframes modalFadeIn {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
    }

    .modal-header {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 25px;
        border-bottom: 1px solid #e2e8f0;
        padding-bottom: 15px;
    }

    .modal-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }

    .info-item {
        margin-bottom: 15px;
    }

    .info-label {
        font-size: 12px;
        color: #64748b;
        text-transform: uppercase;
        font-weight: bold;
        display: block;
    }

    .info-value {
        font-size: 16px;
        color: #1e293b;
        font-weight: 500;
    }

    .action-group {
        display: flex;
        gap: 10px;
        margin-top: 30px;
    }

    .status-badge {
        padding: 4px 12px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 600;
    }

    /* ACTION BUTTONS IN TABLE */
    .table-btn {
        padding: 8px 15px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 12px;
        font-weight: bold;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
    }

    .btn-suspend { background: #fff7ed; color: #c2410c; border: 1px solid #fdba74; }
    .btn-suspend:hover { background: #ffedd5; }
    .btn-verify { background: #f0fdf4; color: #15803d; border: 1px solid #86efac; }
    .btn-verify:hover { background: #dcfce7; }
    .btn-deny { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
    .btn-deny:hover { background: #fee2e2; }

    tr.user-row { transition: background 0.2s; cursor: pointer; }
    tr.user-row:hover { background: #f8fafc !important; }
</style>

</head>

<body style="margin:0;font-family:Arial;background:#f4f6f9;">

<div style="display:flex;min-height:100vh;">

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
box-shadow:0 5px 20px rgba(0,0,0,0.05);margin-bottom:30px; display:flex; justify-content:space-between; align-items:center;">

<div>
<h2>👤User Records</h2>
<p style="color:#64748b;">
Users registered but not participating as voters.📑✔️
</p>
</div>

<div style="background:#e0f2fe; color:#0369a1; padding:15px; border-radius:10px; font-weight:bold;">
Total Records: <%= (users != null) ? users.size() : 0 %>
</div>

</div>


<div style="background:white;border-radius:10px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);overflow:hidden;">

<table style="width:100%;border-collapse:collapse;">

<tr style="background:#1f2937;color:white;">
<th style="padding:18px; text-align:left;">First Name</th>
<th style="text-align:left;">Last Name</th>
<th style="text-align:left;">Email</th>
<th style="text-align:left;">Role</th>
<th style="text-align:center;">Action Management</th>
</tr>

<%
if(users == null || users.isEmpty()){
%>

<tr>
<td colspan="5" style="text-align:center;padding:40px;color:#888;">
<i class="fa fa-folder-open" style="font-size:40px; color:#cbd5e1; display:block; margin-bottom:10px;"></i>
No users recorded yet
</td>
</tr>

<%
}else{

for(User u : users){
%>

<tr class="user-row" style="border-bottom:1px solid #eee;" onclick="openDetailsModal('<%=u.getFirstName()%>', '<%=u.getLastName()%>', '<%=u.getEmail()%>', '<%=u.getRole()%>', '<%=u.getId()%>')">

<td style="padding:18px; font-weight:bold;"><%=u.getFirstName()%></td>

<td><%=u.getLastName()%></td>

<td style="color:#3b82f6;"><%=u.getEmail()%></td>

<td>
    <span style="background:#f1f5f9; color:#475569; padding:5px 12px; border-radius:15px; font-size:12px; font-weight:bold;">
        <%=u.getRole()%>
    </span>
</td>

<td style="text-align:center; padding:10px;" onclick="event.stopPropagation()">
    <button class="table-btn btn-verify" onclick="location.href='admin?action=verify&id=<%=u.getId()%>'">Verify</button>
    <button class="table-btn btn-suspend" onclick="handleSuspend('<%=u.getId()%>')">Suspend</button>
    <button class="table-btn btn-deny" onclick="if(confirm('Are you sure?')) location.href='admin?action=denyUser&id=<%=u.getId()%>'">Deny</button>
</td>

</tr>

<%
}
}
%>

</table>

</div>

</div>


<div>
<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</div>

</div>

</div>

<div class="modal-overlay" id="userModal">
    <div class="modal-box">
        <div class="modal-header">
            <div style="background:#3b82f6; color:white; width:50px; height:50px; border-radius:50%; display:flex; justify-content:center; align-items:center; font-size:24px;">
                <i class="fa fa-user"></i>
            </div>
            <div>
                <h2 id="modalName" style="margin:0; color:#1e293b;">User Detail</h2>
                <span id="modalRole" class="status-badge" style="background:#dcfce7; color:#166534;">Voter</span>
            </div>
            <i class="fa fa-times" onclick="closeDetailsModal()" style="position:absolute; top:30px; right:30px; cursor:pointer; color:#94a3b8; font-size:20px;"></i>
        </div>

        <div class="modal-grid">
            <div class="info-item">
                <span class="info-label">Full Name</span>
                <span id="modalFullName" class="info-value">Loading...</span>
            </div>
            <div class="info-item">
                <span class="info-label">Email Address</span>
                <span id="modalEmail" class="info-value">Loading...</span>
            </div>
            <div class="info-item">
                <span class="info-label">Account Status</span>
                <span class="info-value" style="color:#22c55e;">● Online</span>
            </div>
            <div class="info-item">
                <span class="info-label">Vote Participation</span>
                <span class="info-value">8 Counts</span>
            </div>
            <div class="info-item">
                <span class="info-label">Category</span>
                <span id="modalCategory" class="info-value">Standard Voter</span>
            </div>
            <div class="info-item">
                <span class="info-label">Identity ID</span>
                <span id="modalUID" class="info-value">#9920</span>
            </div>
        </div>

        <div class="action-group">
            <button onclick="closeDetailsModal()" style="flex:1; padding:12px; border-radius:10px; border:1px solid #e2e8f0; background:white; cursor:pointer; font-weight:bold;">Close Window</button>
            <button id="modalActionBtn" style="flex:2; padding:12px; border-radius:10px; border:none; background:#0f172a; color:white; cursor:pointer; font-weight:bold;">Manage Account</button>
        </div>
    </div>
</div>

<script>
    function openDetailsModal(fname, lname, email, role, id) {
        document.getElementById('modalName').innerText = fname;
        document.getElementById('modalFullName').innerText = fname + " " + lname;
        document.getElementById('modalEmail').innerText = email;
        document.getElementById('modalRole').innerText = role;
        document.getElementById('modalUID').innerText = "#USR-" + id;
        
        document.getElementById('userModal').style.display = 'flex';
    }

    function closeDetailsModal() {
        document.getElementById('userModal').style.display = 'none';
    }

    function handleSuspend(id) {
        let reason = prompt("Enter the reason for suspension:");
        if (reason != null && reason !== "") {
            window.location.href = "admin?action=suspend&id=" + id + "&reason=" + encodeURIComponent(reason);
        }
    }

    // Close modal if clicked outside the box
    window.onclick = function(event) {
        let modal = document.getElementById('userModal');
        if (event.target == modal) {
            closeDetailsModal();
        }
    }
</script>

</body>
</html>
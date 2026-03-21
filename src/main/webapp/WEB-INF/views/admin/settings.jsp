<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bascode.model.entity.Setting"%>
<%@ page import="com.bascode.model.entity.User"%>
<%
    Setting setting = (Setting) request.getAttribute("setting");
    User admin = (User) session.getAttribute("loggedUser");
    String firstName = (admin != null) ? admin.getFirstName() : "Admin";
    String lastName = (admin != null) ? admin.getLastName() : "Pass";
    String email = (admin != null) ? admin.getEmail() : "admin@votify.com";
    String phone = (session.getAttribute("phoneNum") != null) ? (String)session.getAttribute("phoneNum") : "+234 800 000 0000";
    String initial = firstName.substring(0,1).toUpperCase();
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>System Settings | Votify</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2563eb; --dark: #0f172a; --bg: #f8fafc; --border: #e2e8f0; }
        body { margin:0; font-family:'Inter', sans-serif; background:var(--bg); overflow-x:hidden; }
      
        /* Main Layout */
        .main-wrapper { margin-left: 260px; min-height: 100vh;}
        .top-nav { background: white; padding: 20px 40px; border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 100; }
        
        /* Profile Header */
        .profile-card { background: white; margin: 30px; padding: 40px; border-radius: 20px; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.05); display: flex; gap: 60px; animation: fadeInUp 0.6s ease; }
        .profile-left { text-align: center; width: 220px; }
        .big-avatar { width: 160px; height: 160px; background: var(--dark); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 60px; font-weight: 800; margin: 0 auto 25px; border: 5px solid white; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        
        /* Info Rows */
        .info-grid { flex: 1; display: grid; grid-template-columns: 1fr 1fr; gap: 25px; }
        .field-box { border-bottom: 1px solid var(--border); padding-bottom: 10px; }
        .field-label { font-size: 11px; font-weight: 700; color: #64748b; text-transform: uppercase; margin-bottom: 8px; }
        .field-value { font-size: 16px; color: var(--dark); font-weight: 500; }
        .editable-input { width: 100%; border: none; border-bottom: 2px solid var(--primary); font-size: 16px; font-family: inherit; padding: 5px 0; outline: none; background: transparent; }

        /* Buttons & Modals */
        .btn { width: 100%; padding: 12px; border-radius: 8px; border: 1px solid var(--border); background: white; cursor: pointer; font-weight: 600; margin-bottom: 12px; transition: 0.2s; display: flex; align-items: center; justify-content: center; gap: 10px; }
        .btn:hover { border-color: var(--primary); color: var(--primary); transform: translateY(-2px); }
        .btn-save { background: var(--primary); color: white; border: none; padding: 12px 30px; width: auto; align-self: flex-end; }
        .btn-save:hover { background: #1d4ed8; color: white; }

        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(15, 23, 42, 0.7); backdrop-filter: blur(8px); animation: fadeIn 0.3s; }
        .modal-content { background: white; width: 450px; margin: 8% auto; padding: 40px; border-radius: 20px; position: relative; animation: slideDown 0.4s cubic-bezier(0.17, 0.67, 0.83, 0.67); }
        .modal-content h3 { margin: 0 0 20px 0; font-size: 22px; }
        .modal-input { width: 100%; padding: 14px; margin: 10px 0 20px; border: 1px solid var(--border); border-radius: 10px; box-sizing: border-box; font-size: 15px; }

        /* Toast Animation */
        #toast { visibility: hidden; min-width: 250px; background: #10b981; color: white; text-align: center; border-radius: 10px; padding: 16px; position: fixed; z-index: 2000; right: 30px; top: 30px; font-weight: 600; box-shadow: 0 10px 15px rgba(0,0,0,0.1); }
        #toast.show { visibility: visible; animation: slideInRight 0.5s, fadeOut 0.5s 2.5s; }

        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes slideDown { from { transform: translateY(-50px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        @keyframes slideInRight { from { right: -300px; } to { right: 30px; } }
    </style>
</head>

<body style="margin:0;font-family:Arial;background:#f4f6f9;">
  <div class="top-nav">
        <h2 style="font-size:18px; font-weight:600; margin:0; width:100%;">Profile & System Preferences</h2>
        <div style="font-size:13px; color:#64748b;">Logged in as: <b style="color:var(--primary);"><%= email %></b></div>
    </div>
<div style="display:flex;min-height:100vh;">

<div id="toast">Changes saved successfully!</div>

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

<div class="main-wrapper">

    <div class="profile-card">
        <div class="profile-left">
            <div class="big-avatar"><%= initial %></div>
            <button class="btn" onclick="toggleModal('pwdModal')"><i class="fa fa-shield-halved"></i> Security</button>
            <button class="btn" onclick="toggleModal('eleModal')"><i class="fa fa-clock"></i> Election Cycle</button>
        </div>

        <form action="admin" method="POST" class="info-grid">
            <input type="hidden" name="action" value="updateProfile">
            <div class="field-box"><div class="field-label">Email Address</div><div class="field-value"><%= email %></div></div>
            <div class="field-box"><div class="field-label">System Role</div><div class="field-value">Master Administrator</div></div>
            <div class="field-box"><div class="field-label">First Name</div><div class="field-value"><%= firstName %></div></div>
            <div class="field-box"><div class="field-label">Last Name</div><div class="field-value"><%= lastName %></div></div>
            <div class="field-box" style="grid-column: span 2;">
                <div class="field-label">Personal Phone Number (Editable)</div>
                <input type="text" name="phone" value="<%= phone %>" class="editable-input">
            </div>
            <div style="grid-column: span 2; display:flex; justify-content:flex-end;">
                <button type="submit" class="btn btn-save"><i class="fa fa-save"></i> Save Profile Details</button>
            </div>
        </form>
    </div>
</div>
</div>

<div id="pwdModal" class="modal">
    <div class="modal-content">
        <h3>Change Password</h3>
        <form action="admin" method="POST">
            <input type="hidden" name="action" value="updatePassword">
            <div class="field-label">Current Password</div>
            <input type="password" name="currentPassword" class="modal-input" required>
            <div class="field-label">New Password</div>
            <input type="password" name="newPassword" class="modal-input" required>
            <div class="field-label">Confirm New Password</div>
            <input type="password" name="confirmPassword" class="modal-input" required>
            <button type="submit" class="btn btn-save" style="width:100%">Update Security Key</button>
        </form>
    </div>
</div>

<div id="eleModal" class="modal">
    <div class="modal-content">
        <h3>Election Timing</h3>
        <form action="admin" method="POST">
            <input type="hidden" name="action" value="updateSettings">
            <div class="field-label">Election Name</div>
            <input type="text" name="electionName" value="<%= (setting != null) ? setting.getElectionName() : "" %>" class="modal-input">
            <div class="field-label">Start Date</div>
            <input type="date" name="startDate" value="<%= (setting != null) ? setting.getStartDate() : "" %>" class="modal-input">
            <div class="field-label">End Date</div>
            <input type="date" name="endDate" value="<%= (setting != null) ? setting.getEndDate() : "" %>" class="modal-input">
            <button type="submit" class="btn btn-save" style="width:100%">Save System Dates</button>
        </form>
    </div>
    </div>


<script>
    function toggleModal(id) {
        const m = document.getElementById(id);
        m.style.display = (m.style.display === 'block') ? 'none' : 'block';
    }
    window.onclick = function(event) {
        if (event.target.className === 'modal') event.target.style.display = "none";
    }

    // Success Toast Logic
    <% if (msg != null) { %>
        const toast = document.getElementById("toast");
        <% if (msg.equals("election_success")) { %> toast.innerText = "Election parameters updated!"; <% } %>
        <% if (msg.equals("profile_success")) { %> toast.innerText = "Phone number saved!"; <% } %>
        <% if (msg.equals("pass_success")) { %> toast.innerText = "Password updated successfully!"; <% } %>
        toast.className = "show";
        setTimeout(() => { toast.className = toast.className.replace("show", ""); }, 3000);
    <% } %>
</script>
</body>
</html>
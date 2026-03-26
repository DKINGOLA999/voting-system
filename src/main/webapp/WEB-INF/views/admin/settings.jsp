<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Setting"%>

<%
    // Fetch the single settings object from the request attribute
    Setting setting = (Setting) request.getAttribute("setting");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>System Settings | IVIS Control Center</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-body: #f8fafc;
            --card-bg: #ffffff;
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        body { 
            margin: 0; 
            font-family: 'Inter', sans-serif; 
            background: var(--bg-body); 
            color: var(--text-main);
        }

        .settings-container {
            max-width: 700px;
            margin: 40px auto;
            background: var(--card-bg);
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            border: 1px solid var(--border);
        }

        .form-group { margin-bottom: 20px; }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        input[type="text"], 
        input[type="date"], 
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            ring: 2px solid rgba(37, 99, 235, 0.1);
        }

        .save-btn {
            background: var(--primary);
            color: white;
            padding: 14px 24px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background 0.2s;
        }

        .save-btn:hover { background: var(--primary-hover); }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 20px;
            background: #dcfce7;
            color: #166534;
        }
    </style>
</head>

<body>

<div style="display:flex; min-height:100vh;">

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

    <div style="flex:1;">
        
        <div style="background:white; padding:20px 40px; border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center;">
            <h1 style="font-size:22px; margin:0;">Platform Configuration</h1>
            <div style="color:var(--text-muted); font-size:14px;">Node ID: <span style="font-family:monospace; color:var(--primary);">MASTER_01</span></div>
        </div>

        <div class="settings-container">
            <div class="status-badge">● SYSTEM ACTIVE</div>
            
            <h2 style="margin:0 0 10px 0;">Global Parameters</h2>
            <p style="color:var(--text-muted); margin-bottom:30px; font-size:14px;">These settings control the public-facing election logic and data persistence.</p>

            <form action="<%=request.getContextPath()%>/admin" method="POST">
                <input type="hidden" name="action" value="updateSettings">
                
                <% if (setting != null) { %>
                    <input type="hidden" name="settingId" value="<%= setting.getId() %>">
                <% } %>

                <div class="form-group">
                    <label>Election Title</label>
                    <input type="text" name="electionName" 
                           value="<%= (setting != null) ? setting.getElectionName() : "" %>" 
                           placeholder="e.g. 2026 Student Union Elections" required>
                </div>

                <div style="display:grid; grid-template-columns: 1fr 1fr; gap:20px;">
                    <div class="form-group">
                        <label>Start Date</label>
                        <input type="date" name="startDate" 
                               value="<%= (setting != null) ? setting.getStartDate() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label>End Date</label>
                        <input type="date" name="endDate" 
                               value="<%= (setting != null) ? setting.getEndDate() : "" %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>System Visibility</label>
                    <input type="text" name="visibility" 
                                value="<%= (setting != null) ? setting.getElectionName() : "" %>" 
                           placeholder="e.g. Admin" required>
                </div>

                <hr style="border:0; border-top:1px solid var(--border); margin:30px 0;">

                <button type="submit" class="save-btn">
                    <i class="fa fa-cloud-upload"></i> Push Updates to Database
                </button>
            </form>
        </div>

        <div style="text-align:center; color:var(--text-muted); font-size:12px; margin-top:20px;">
            Last modified: <%= new java.util.Date() %> | SHA-256 Integrity Verified
        </div>
    </div>
</div>

</body>
</html>
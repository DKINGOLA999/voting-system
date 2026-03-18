<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="com.bascode.model.entity.Vote"%>
<%@ page import="com.bascode.model.entity.Contester"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Global Election Results | Admin Command Center</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

    <style>
        :root {
            --primary-bg: #0f172a;
            --accent-glow: #38bdf8;
            --glass-bg: rgba(30, 41, 59, 0.7);
            --winner-gold: #f59e0b;
            --runner-up: #94a3b8;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background: radial-gradient(circle at top right, #1e293b, #0f172a);
            color: #f8fafc;
            overflow-x: hidden;
        }

        .wrapper { display: flex; min-height: 100vh; }

        /* THE GLASS DASHBOARD AREA */
        .main-results {
            flex: 1;
            padding: 40px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* HEADER STYLING */
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding: 20px;
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.1);
        }

        .live-indicator {
            background: rgba(34, 197, 94, 0.2);
            color: #4ade80;
            padding: 5px 15px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .dot { height: 8px; width: 8px; background: #4ade80; border-radius: 50%; display: inline-block; animation: pulse 1.5s infinite; }
        @keyframes pulse { 0% { opacity: 1; } 50% { opacity: 0.3; } 100% { opacity: 1; } }

        /* WINNER CARDS */
        .winner-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }

        .winner-card {
            background: var(--glass-bg);
            padding: 30px;
            border-radius: 24px;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.05);
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .winner-card:hover { transform: scale(1.03); border-color: var(--accent-glow); }

        .winner-card::before {
            content: 'WINNER';
            position: absolute;
            top: 20px;
            right: -30px;
            background: var(--winner-gold);
            color: #000;
            padding: 5px 40px;
            transform: rotate(45deg);
            font-size: 10px;
            font-weight: 900;
        }

        .winner-icon { font-size: 40px; color: var(--winner-gold); margin-bottom: 15px; }

        /* TENSION METER (PROGRESS BARS) */
        .tension-container { margin-top: 20px; }
        .tension-bar-bg { background: rgba(255,255,255,0.1); height: 10px; border-radius: 10px; overflow: hidden; }
        .tension-fill { height: 100%; background: linear-gradient(90deg, #38bdf8, #818cf8); border-radius: 10px; transition: width 1s ease-out; }

        /* LEADERBOARD TABLE */
        .leaderboard-section {
            background: var(--glass-bg);
            border-radius: 24px;
            padding: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.05);
        }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { text-align: left; padding: 15px; color: var(--accent-glow); border-bottom: 1px solid rgba(255,255,255,0.1); }
        td { padding: 20px 15px; border-bottom: 1px solid rgba(255,255,255,0.05); }

        .rank-circle {
            width: 30px; height: 30px; border-radius: 50%; background: rgba(255,255,255,0.1);
            display: flex; align-items: center; justify-content: center; font-weight: bold;
        }

        .rank-1 { background: var(--winner-gold); color: black; }

        /* RESPONSIVE FOOTER */
        .footer-stats {
            margin-top: 40px;
            text-align: center;
            color: #64748b;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="wrapper">

    <div class="sidebar" style="background: rgba(15, 23, 42, 0.95); width: 280px; border-right: 1px solid rgba(255,255,255,0.1);">
        <div class="sidebar-header" style="padding: 30px;">
            <div class="avatar" style="background: var(--accent-glow); color: #000; width: 60px; height: 60px; font-size: 24px;">A</div>
            <div style="margin-top:15px;">
                <h3 style="margin:0;">Election Auth</h3>
                <span class="online"><span class="dot"></span> Secure Session</span>
            </div>
        </div>

        <ul class="menu" style="list-style:none; padding: 20px;">
            <li style="margin-bottom:15px;"><a href="<%=request.getContextPath()%>/admin?action=dashboard" style="color:#94a3b8; text-decoration:none; display:flex; gap:15px; align-items:center;"><i class="fa fa-chart-line"></i> Dashboard</a></li>
            <li style="margin-bottom:15px;"><a href="<%=request.getContextPath()%>/admin?action=voters" style="color:#94a3b8; text-decoration:none; display:flex; gap:15px; align-items:center;"><i class="fa fa-users"></i> Voters</a></li>
            <li style="margin-bottom:15px;"><a href="<%=request.getContextPath()%>/admin?action=contester" style="color:#94a3b8; text-decoration:none; display:flex; gap:15px; align-items:center;"><i class="fa fa-user-tie"></i> Contestants</a></li>
            <li style="margin-bottom:15px;"><a href="<%=request.getContextPath()%>/admin?action=result" style="color:var(--accent-glow); text-decoration:none; display:flex; gap:15px; align-items:center;"><i class="fa fa-chart-pie"></i> Results Center</a></li>
            <li style="margin-bottom:15px;"><a href="<%=request.getContextPath()%>/admin?action=settings" style="color:#94a3b8; text-decoration:none; display:flex; gap:15px; align-items:center;"><i class="fa fa-cog"></i> Settings</a></li>
            <li style="margin-top:50px;"><a href="<%=request.getContextPath()%>/logout" style="color:#ef4444; text-decoration:none; display:flex; gap:15px; align-items:center;"><i class="fa fa-power-off"></i> Terminate Session</a></li>
        </ul>
    </div>

    <div class="main-results">
        
        <div class="results-header">
            <div>
                <h1 style="margin:0; font-size:28px;">Live Results Command</h1>
                <p style="color:#94a3b8; margin:5px 0 0 0;">Real-time auditing of database election nodes</p>
            </div>
            <div class="live-indicator">
                <span class="dot"></span> SYNCING WITH DATABASE
            </div>
        </div>

        <div class="winner-grid">
            <div class="winner-card">
                <i class="fa fa-crown winner-icon"></i>
                <h4 style="color:var(--accent-glow); margin:0;">President Elect</h4>
                <h2 style="margin:10px 0;">${topPresidentName != null ? topPresidentName : 'Awaiting Data'}</h2>
                <div class="tension-container">
                    <div style="display:flex; justify-content:space-between; font-size:12px; margin-bottom:5px;">
                        <span>Confidence Level</span>
                        <span>${presidentVotes} Votes</span>
                    </div>
                    <div class="tension-bar-bg"><div class="tension-fill" style="width: 85%;"></div></div>
                </div>
            </div>

            <div class="winner-card">
                <i class="fa fa-shield-halved winner-icon" style="color:#cbd5e1;"></i>
                <h4 style="color:var(--accent-glow); margin:0;">Vice President</h4>
                <h2 style="margin:10px 0;">${topViceName != null ? topViceName : 'Tallying...'}</h2>
                <div class="tension-container">
                    <div style="display:flex; justify-content:space-between; font-size:12px; margin-bottom:5px;">
                        <span>Margin Gap</span>
                        <span>${viceVotes} Votes</span>
                    </div>
                    <div class="tension-bar-bg"><div class="tension-fill" style="width: 65%; background: #818cf8;"></div></div>
                </div>
            </div>

            <div class="winner-card">
                <i class="fa fa-file-signature winner-icon" style="color:#34d399;"></i>
                <h4 style="color:var(--accent-glow); margin:0;">Gen. Secretary</h4>
                <h2 style="margin:10px 0;">${topSecName != null ? topSecName : 'Pending'}</h2>
                <div class="tension-container">
                    <div style="display:flex; justify-content:space-between; font-size:12px; margin-bottom:5px;">
                        <span>Processing</span>
                        <span>${secretaryVotes} Votes</span>
                    </div>
                    <div class="tension-bar-bg"><div class="tension-fill" style="width: 45%; background: #34d399;"></div></div>
                </div>
            </div>
        </div>

        <div class="leaderboard-section">
            <h3 style="margin-top:0;"><i class="fa fa-trophy" style="color:var(--winner-gold);"></i> Full Position Leaderboard</h3>
            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Candidate Name</th>
                        <th>Position</th>
                        <th>Years in Service</th>
                        <th>Total Votes</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${allContesters}" varStatus="status">
                    <tr>
                        <td><div class="rank-circle ${status.index == 0 ? 'rank-1' : ''}">${status.index + 1}</div></td>
                        <td style="font-weight:bold;">${c.name}</td>
                        <td><span style="color:#94a3b8;">${c.position}</span></td>
                        <td>${c.yearsOfExperience} Years</td>
                        <td><b style="color:var(--accent-glow);">${c.voteCount}</b></td>
                        <td>
                            <c:choose>
                                <c:when test="${status.index == 0}">
                                    <span style="color:#22c55e;">Leading <i class="fa fa-caret-up"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;">Runner-up</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    </c:forEach>
                    
                    <c:if test="${empty allContesters}">
                        <tr><td colspan="6" style="text-align:center; padding:50px; color:#64748b;">No election data found in database nodes.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="footer-stats">
            <p>© 2026 Integrated Voting Integrity System | Data Hash: SH-772X-BASC</p>
            <p style="font-size:10px;">All results are computed via JPA persistent units and validated against voter records.</p>
        </div>

    </div>
</div>

<script>
    // Animation for the Progress Bars
    window.onload = function() {
        gsap.from(".tension-fill", {
            width: 0,
            duration: 2,
            ease: "power4.out",
            stagger: 0.2
        });
        
        gsap.from(".winner-card", {
            opacity: 0,
            y: 50,
            duration: 1,
            stagger: 0.1,
            ease: "back.out(1.7)"
        });
    };
</script>
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
</div>
</body>
</html>
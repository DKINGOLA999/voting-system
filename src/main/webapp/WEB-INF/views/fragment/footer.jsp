<%@ page contentType="text/html;charset=UTF-8" %>

<footer style="
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

</footer>
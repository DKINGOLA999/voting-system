<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>
<meta charset="UTF-8">
<title>dashboard</title>
 <style>
    body { font-family: Arial, sans-serif; background: #f4f6f9; margin:0; padding:0; }
    .container { width: 90%; max-width: 900px; margin: 30px auto; }
    h1 { text-align: center; color: #2563eb; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background-color: #0f172a; color: white; }
    tr:nth-child(even) { background-color: #f3f4f6; }
    .vote-btn { padding: 6px 12px; border: none; border-radius: 5px; cursor: pointer; }
    .approve { background: #10b981; color: white; }
    .approve:hover { background: #059669; }
    .decline { background: #ef4444; color: white; }
    .decline:hover { background: #dc2626; }
    .status { padding: 4px 8px; border-radius: 4px; font-weight: bold; }
    .pending { background: #facc15; color: black; }
    .approved { background: #10b981; color: white; }
    .declined { background: #ef4444; color: white; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>
<div class="container">
    <h1>Admin Voting Panel</h1>

    <table>
      <thead>
        <tr>
          <th>Candidate</th>
          <th>Votes</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody id="vote-table">
        <tr>
          <td>Sublime Option A</td>
          <td>150</td>
          <td><span class="status pending">Pending</span></td>
          <td>
            <button class="vote-btn approve" onclick="vote(this, 'approved')">Approve</button>
            <button class="vote-btn decline" onclick="vote(this, 'declined')">Decline</button>
          </td>
        </tr>
        <tr>
          <td>Sublime Option B</td>
          <td>200</td>
          <td><span class="status pending">Pending</span></td>
          <td>
            <button class="vote-btn approve" onclick="vote(this, 'approved')">Approve</button>
            <button class="vote-btn decline" onclick="vote(this, 'declined')">Decline</button>
          </td>
        </tr>
        <tr>
          <td>Sublime Option C</td>
          <td>120</td>
          <td><span class="status pending">Pending</span></td>
          <td>
            <button class="vote-btn approve" onclick="vote(this, 'approved')">Approve</button>
            <button class="vote-btn decline" onclick="vote(this, 'declined')">Decline</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>

  <script>
    function vote(button, action) {
      const row = button.closest('tr');
      const statusSpan = row.querySelector('.status');

      if(action === 'approved') {
        statusSpan.textContent = 'Approved';
        statusSpan.className = 'status approved';
        alert(`${row.cells[0].textContent} approved!`);
      } else {
        statusSpan.textContent = 'Declined';
        statusSpan.className = 'status declined';
        alert(`${row.cells[0].textContent} declined!`);
      }
    }
  </script>
  <%@ include file="/WEB-INF/views/fragment/footer.jsp" %>
</body>
</html>
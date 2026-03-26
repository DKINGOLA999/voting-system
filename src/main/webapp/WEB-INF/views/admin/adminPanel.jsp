<%@ page contentType="text/html;charset=UTF-8" import="java.util.List, com.bascode.model.entity.User, com.bascode.model.entity.Contester, com.bascode.model.entity.Election" %>
<%
User admin = (User) session.getAttribute("user");
if (admin == null || !admin.getRole().equals(com.bascode.model.enums.Role.ADMIN)) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}

List<User> users = (List<User>) request.getAttribute("users");
List<Contester> pendingContesters = (List<Contester>) request.getAttribute("pendingContesters");
Election currentElection = (Election) request.getAttribute("currentElection");
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp"%>
    <title>Admin Panel - Votify</title>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">Votify Admin</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <h2>Admin Panel</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>

        <div class="row">
            <div class="col-md-8">
                <div class="card p-3">
                    <h4>Pending Contester Approvals</h4>
                    <% if (pendingContesters != null && !pendingContesters.isEmpty()) {
                        for (Contester c : pendingContesters) {
                    %>
                        <div class="card mb-3 border-warning">
                            <div class="card-body">
                                <h5 class="card-title"><%= c.getUser().getFirstName() %> <%= c.getUser().getLastName() %></h5>
                                <p class="card-text"><strong>Position:</strong> <%= c.getPosition() %></p>
                                <p class="card-text"><strong>Manifesto Preview:</strong></p>
                                <div class="manifesto-preview bg-light p-2 rounded" style="max-height: 100px; overflow: hidden;">
                                    <%= c.getManifesto() != null ? c.getManifesto().substring(0, Math.min(200, c.getManifesto().length())) + (c.getManifesto().length() > 200 ? "..." : "") : "No manifesto provided" %>
                                </div>
                                <div class="mt-3">
                                    <button class="btn btn-info btn-sm me-2" onclick="showManifesto('<%= c.getId() %>', '<%= c.getUser().getFirstName() %> <%= c.getUser().getLastName() %>', '<%= c.getPosition() %>', '<%= c.getManifesto() != null ? c.getManifesto().replaceAll("'", "\\\\'").replaceAll("\"", "&quot;") : "" %>')">View Full Manifesto</button>
                                    <form method="post" action="panel" style="display:inline">
                                        <input type="hidden" name="action" value="approve" />
                                        <input type="hidden" name="contesterId" value="<%= c.getId() %>" />
                                        <button class="btn btn-success btn-sm">Approve</button>
                                    </form>
                                    <form method="post" action="panel" style="display:inline">
                                        <input type="hidden" name="action" value="reject" />
                                        <input type="hidden" name="contesterId" value="<%= c.getId() %>" />
                                        <button class="btn btn-danger btn-sm">Reject</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    <% } } else { %>
                        <p class="text-center text-muted">No pending approvals.</p>
                    <% } %>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card p-3">
                    <h4>All Users</h4>
                    <table class="table table-striped">
                        <thead>
                        <tr><th>Name</th><th>Email</th><th>Role</th></tr>
                        </thead>
                        <tbody>
                        <% if (users != null) {
                            for (User u : users) {
                        %>
                            <tr>
                                <td><%= u.getFirstName() %> <%= u.getLastName() %></td>
                                <td><%= u.getEmail() %></td>
                                <td><%= u.getRole() %></td>
                            </tr>
                        <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        <div class="row mt-4">
            <div class="col-12">
                <div class="card p-3">
                    <h4>Election Management</h4>
                    <% if (currentElection != null) { %>
                        <p><strong>Current Election:</strong></p>
                        <p>Start: <%= currentElection.getStartDate() != null ? currentElection.getStartDate().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) : "Not set" %></p>
                        <p>End: <%= currentElection.getEndDate() != null ? currentElection.getEndDate().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) : "Not set" %></p>
                        <form method="post" action="panel" style="display:inline">
                            <input type="hidden" name="action" value="startElection" />
                            <button class="btn btn-success btn-sm">Start Election Now</button>
                        </form>
                        <form method="post" action="panel" style="display:inline">
                            <input type="hidden" name="action" value="endElection" />
                            <button class="btn btn-danger btn-sm">End Election Now</button>
                        </form>
                    <% } %>
                    <h5>Set Election Dates</h5>
                    <form method="post" action="panel">
                        <input type="hidden" name="action" value="setElectionDates" />
                        <div class="row">
                            <div class="col-md-5">
                                <label>Start Date & Time</label>
                                <input type="datetime-local" name="startDate" class="form-control" required />
                            </div>
                            <div class="col-md-5">
                                <label>End Date & Time</label>
                                <input type="datetime-local" name="endDate" class="form-control" required />
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button class="btn btn-primary">Set Dates</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    <%@ include file="/WEB-INF/views/fragment/footer.jsp"%>
</body>
</html>
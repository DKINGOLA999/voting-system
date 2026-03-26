<%@ page contentType="text/html;charset=UTF-8" import="java.util.List, com.bascode.model.entity.Contester"%>
<%
com.bascode.model.entity.User user = (com.bascode.model.entity.User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}

List<Contester> contesters = (List<Contester>) request.getAttribute("contesters");
Boolean hasVoted = Boolean.TRUE.equals(request.getAttribute("hasVoted"));
Boolean isContester = Boolean.TRUE.equals(request.getAttribute("isContester"));
Boolean eligible = Boolean.TRUE.equals(request.getAttribute("eligible"));
java.util.Map<Long, Long> voteCount = (java.util.Map<Long, Long>) request.getAttribute("voteCount");
com.bascode.model.enums.Position[] positions = (com.bascode.model.enums.Position[]) request.getAttribute("positions");
Boolean votingOpen = Boolean.TRUE.equals(request.getAttribute("votingOpen"));
java.time.LocalDateTime deadline = (java.time.LocalDateTime) request.getAttribute("deadline");
com.bascode.model.enums.ContesterStatus contesterStatus = (com.bascode.model.enums.ContesterStatus) request.getAttribute("contesterStatus");
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp"%>
    <title>Dashboard - Votify</title>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/">Votify</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/services.jsp">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/contacts.jsp">Contacts</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/results">Results</a></li>
                    <li class="nav-item"><a class="nav-link active" href="<%= request.getContextPath() %>/dashboard">Dashboard</a></li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <%= user.getFirstName() != null && !user.getFirstName().isEmpty() ? user.getFirstName() + " " + user.getLastName() : user.getEmail() %>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/dashboard">Dashboard</a></li>
                            <% if (user.getRole().equals(com.bascode.model.enums.Role.ADMIN)) { %>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/admin/panel">Admin Panel</a></li>
                            <% } %>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row g-3 mb-4">
            <div class="col-md-8">
                <div class="card bg-dark text-white shadow-sm">
                    <div class="card-body">
                        <h3 class="card-title">Welcome, <%= user.getFirstName() != null && !user.getFirstName().isEmpty() ? user.getFirstName() + " " + user.getLastName() : user.getEmail() %></h3>
                        <p class="card-text">Role: <strong><%= user.getRole() %></strong></p>
                        <p class="card-text">Use the navigation links to vote, submit manifesto, and view results.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">Quick Actions</h6>
                        <a href="<%= request.getContextPath() %>/results" class="btn btn-primary btn-sm w-100 mb-2">View Results</a>
                        <a href="<%= request.getContextPath() %>/admin/panel" class="btn btn-secondary btn-sm w-100" role="button">Admin Panel</a>
                    </div>
                </div>
            </div>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>

        <% if (deadline != null) { %>
            <div class="alert <%= votingOpen ? "alert-info" : "alert-warning" %>">
                <strong>Voting <%= votingOpen ? "Open" : "Closed" %></strong> - 
                Deadline: <%= deadline.format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' HH:mm")) %>
                <% if (!votingOpen) { %>
                    <span class="text-danger">(Voting period has ended)</span>
                <% } %>
            </div>
        <% } %>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card p-3">
                    <h4>Profile</h4>
                    <form method="post" action="dashboard">
                        <input type="hidden" name="action" value="profile" />
                        <div class="mb-2"><label>First Name</label>
                            <input class="form-control" name="firstName" value="<%= user.getFirstName() %>" required /></div>
                        <div class="mb-2"><label>Last Name</label>
                            <input class="form-control" name="lastName" value="<%= user.getLastName() %>" required /></div>
                        <button class="btn btn-primary w-100">Update Profile</button>
                    </form>
                </div>

                <div class="card p-3 mt-3">
                    <h4>Change Password</h4>
                    <form method="post" action="dashboard">
                        <input type="hidden" name="action" value="changePassword" />
                        <div class="mb-2"><label>Current Password</label>
                            <input class="form-control" type="password" name="currentPassword" required /></div>
                        <div class="mb-2"><label>New Password</label>
                            <input class="form-control" type="password" name="password" required /></div>
                        <div class="mb-2"><label>Confirm New Password</label>
                            <input class="form-control" type="password" name="confirmPassword" required /></div>
                        <button class="btn btn-primary w-100">Change Password</button>
                    </form>
                </div>

                <div class="card p-3 mt-3">
                    <h4>Contest</h4>
                    <% if (contesterStatus != null) { %>
                        <% if (contesterStatus == com.bascode.model.enums.ContesterStatus.PENDING) { %>
                            <p class="text-warning">Your contester application is pending admin approval.</p>
                        <% } else if (contesterStatus == com.bascode.model.enums.ContesterStatus.APPROVED) { %>
                            <p class="text-success">You are currently an approved contester.</p>
                        <% } else if (contesterStatus == com.bascode.model.enums.ContesterStatus.DENIED) { %>
                            <p class="text-danger">Your contester application was denied. You can apply again.</p>
                        <% } %>
                    <% } %>
                    <form method="post" action="dashboard">
                        <input type="hidden" name="action" value="contest" />
                        <select name="position" class="form-select mb-2" required <%= (isContester || contesterStatus == com.bascode.model.enums.ContesterStatus.PENDING) ? "disabled" : "" %>>
                            <option value="">Choose position</option>
                            <% for (com.bascode.model.enums.Position p : positions) { %>
                                <option><%= p %></option>
                            <% } %>
                        </select>
                        <div class="mb-2">
                            <label>Manifesto (max 500 words)</label>
                            <textarea name="manifesto" class="form-control" rows="6" maxlength="2500" 
                                placeholder="Describe your vision, goals, and what you hope to achieve if elected..." 
                                required <%= (isContester || contesterStatus == com.bascode.model.enums.ContesterStatus.PENDING) ? "disabled" : "" %>></textarea>
                            <small class="text-muted">Characters: <span id="charCount">0</span>/2500</small>
                        </div>
                        <button class="btn btn-success w-100" <%= (isContester || contesterStatus == com.bascode.model.enums.ContesterStatus.PENDING || !eligible) ? "disabled" : "" %>>Become Contester</button>
                    </form>
                    <form method="post" action="dashboard" class="mt-2">
                        <input type="hidden" name="action" value="withdraw" />
                        <button class="btn btn-warning w-100" <%= isContester ? "" : "disabled" %>>Withdraw</button>
                    </form>
                    <% if (!eligible) { %>
                        <div class="text-danger mt-2">Only users age 18 or older can contest or vote.</div>
                    <% } %>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card p-3">
                    <h4>Candidate List</h4>
                    <table class="table table-striped">
                        <thead>
                        <tr><th>Name</th><th>Position</th><th>Total Votes</th><th>Vote</th></tr>
                        </thead>
                        <tbody>
                        <% if (contesters != null && !contesters.isEmpty()) {
                            for (Contester c : contesters) {
                                long votes = voteCount != null && voteCount.get(c.getId()) != null ? voteCount.get(c.getId()) : 0;
                                boolean disableVote = !eligible || hasVoted || !votingOpen || (user.getRole() == com.bascode.model.enums.Role.CONTESTER && !c.getUser().getId().equals(user.getId()));
                        %>
                            <tr>
                                <td><%= c.getUser().getFirstName() %> <%= c.getUser().getLastName() %></td>
                                <td><%= c.getPosition() %></td>
                                <td><%= votes %></td>
                                <td>
                                    <form method="post" action="dashboard" style="display:inline">
                                        <input type="hidden" name="action" value="vote" />
                                        <input type="hidden" name="contesterId" value="<%= c.getId() %>" />
                                        <button class="btn btn-sm btn-primary" <%= disableVote ? "disabled" : "" %>>Vote</button>
                                    </form>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr><td colspan="4" class="text-center">No approved contesters yet.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                    <p class="text-muted">* Voters can vote once. Contesters can only vote for themselves once.</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Character counter for manifesto
        document.addEventListener('DOMContentLoaded', function() {
            const manifestoTextarea = document.querySelector('textarea[name="manifesto"]');
            const charCount = document.getElementById('charCount');
            
            if (manifestoTextarea && charCount) {
                manifestoTextarea.addEventListener('input', function() {
                    const count = this.value.length;
                    charCount.textContent = count;
                    charCount.style.color = count > 2500 ? 'red' : count > 2000 ? 'orange' : 'green';
                });
            }
        });

        // Add loading state to forms
        document.addEventListener('submit', function(e) {
            const submitBtn = e.target.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.classList.add('btn-loading');
                submitBtn.disabled = true;
            }
        });
    </script>

    <%@ include file="/WEB-INF/views/fragment/footer.jsp"%>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.List, java.util.Map, com.bascode.model.entity.Contester, com.bascode.model.enums.Position" %>
<%
Map<Position, List<Contester>> results = (Map<Position, List<Contester>>) request.getAttribute("results");
Map<Long, Long> voteCounts = (Map<Long, Long>) request.getAttribute("voteCounts");
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>
    <title>Election Results - Votify</title>
</head>
<body>
<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

<div class="container py-5">
    <h1 class="text-center mb-4">Election Results</h1>

    <% if (results != null && !results.isEmpty()) {
        for (Position pos : Position.values()) {
            List<Contester> contesters = results.get(pos);
    %>
        <div class="card mb-4">
            <div class="card-header">
                <h3><%= pos %></h3>
            </div>
            <div class="card-body">
                <% if (contesters != null && !contesters.isEmpty()) { %>
                    <table class="table table-striped">
                        <thead>
                        <tr><th>Rank</th><th>Name</th><th>Votes</th></tr>
                        </thead>
                        <tbody>
                        <% int rank = 1;
                        for (Contester c : contesters) {
                            long votes = voteCounts.getOrDefault(c.getId(), 0L);
                        %>
                            <tr>
                                <td><%= rank++ %></td>
                                <td><%= c.getUser().getFirstName() %> <%= c.getUser().getLastName() %></td>
                                <td><%= votes %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p>No contesters for this position.</p>
                <% } %>
            </div>
        </div>
    <% } } else { %>
        <p class="text-center">No election results available.</p>
    <% } %>
</div>

<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>
</body>
</html>
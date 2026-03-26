package com.bascode.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.bascode.model.entity.Contester;
import com.bascode.model.enums.Position;
import com.bascode.services.UserService;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/results")
public class ResultsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (EntityManager em = JPAUtil.getEntityManager()) {
            UserService service = new UserServiceImpl(em);
            List<Contester> approvedContesters = service.getApprovedContesters();
            
            // Group by position and sort by votes descending
            Map<Position, List<Contester>> results = new java.util.HashMap<>();
            for (Position pos : Position.values()) {
                List<Contester> posContesters = approvedContesters.stream()
                    .filter(c -> c.getPosition() == pos)
                    .sorted((c1, c2) -> Long.compare(service.countVotesForContester(c2), service.countVotesForContester(c1)))
                    .collect(java.util.stream.Collectors.toList());
                if (!posContesters.isEmpty()) {
                    results.put(pos, posContesters);
                }
            }
            
            Map<Long, Long> voteCounts = new java.util.HashMap<>();
            for (Contester c : approvedContesters) {
                voteCounts.put(c.getId(), service.countVotesForContester(c));
            }
            
            request.setAttribute("results", results);
            request.setAttribute("voteCounts", voteCounts);
            request.getRequestDispatcher("/WEB-INF/views/results.jsp").forward(request, response);
        }
    }
}
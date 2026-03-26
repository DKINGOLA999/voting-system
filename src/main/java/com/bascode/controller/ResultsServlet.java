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
            Map<Position, List<Contester>> results = service.getElectionResults();
            Map<Long, Long> voteCounts = new java.util.HashMap<>();
            for (List<Contester> contesters : results.values()) {
                for (Contester c : contesters) {
                    voteCounts.put(c.getId(), service.countVotesForContester(c));
                }
            }
            request.setAttribute("results", results);
            request.setAttribute("voteCounts", voteCounts);
            request.getRequestDispatcher("/WEB-INF/views/results.jsp").forward(request, response);
        }
    }
}
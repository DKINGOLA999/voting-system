package com.bascode.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bascode.model.entity.Contester;
import com.bascode.model.entity.Election;
import com.bascode.model.entity.User;
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try (EntityManager em = JPAUtil.getEntityManager()) {
            UserService service = new UserServiceImpl(em);
            List<Contester> contesters = service.getApprovedContesters();
            Map<Long, Long> voteCount = new HashMap<>();
            for (Contester c : contesters) {
                voteCount.put(c.getId(), service.countVotesForContester(c));
            }

            boolean isEligible = false;
            if (user.getBirthDate() != null) {
                java.time.Period period = java.time.Period.between(user.getBirthDate(), java.time.LocalDate.now());
                isEligible = period.getYears() >= 18;
            }

            // Check voting deadline
            Election election = service.getCurrentElection();
            boolean votingOpen = false;
            java.time.LocalDateTime deadline = null;
            if (election != null && election.getStartDate() != null && election.getEndDate() != null) {
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                votingOpen = now.isAfter(election.getStartDate()) && now.isBefore(election.getEndDate());
                deadline = election.getEndDate();
            }
            request.setAttribute("votingOpen", votingOpen);
            request.setAttribute("deadline", deadline);

            request.setAttribute("contesters", contesters);
            request.setAttribute("voteCount", voteCount);
            request.setAttribute("hasVoted", service.hasUserVoted(user));
            request.setAttribute("isContester", service.isUserContester(user));
            request.setAttribute("contesterStatus", service.getContesterStatus(user));
            request.setAttribute("positions", Position.values());
            request.setAttribute("eligible", isEligible);

            request.getRequestDispatcher("/WEB-INF/views/protected/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try (EntityManager em = JPAUtil.getEntityManager()) {
            UserService service = new UserServiceImpl(em);
            String action = request.getParameter("action");

            boolean isEligible = false;
            if (user.getBirthDate() != null) {
                java.time.Period period = java.time.Period.between(user.getBirthDate(), java.time.LocalDate.now());
                isEligible = period.getYears() >= 18;
            }

            if (!isEligible && ("contest".equals(action) || "vote".equals(action))) {
                request.setAttribute("error", "You must be at least 18 years old to contest or vote.");
                doGet(request, response);
                return;
            }

            switch (action == null ? "" : action) {
                case "contest": {
                    String positionName = request.getParameter("position");
                    String manifesto = request.getParameter("manifesto");
                    
                    if (positionName == null || positionName.trim().isEmpty()) {
                        request.setAttribute("error", "Position is required.");
                        break;
                    }
                    
                    if (manifesto == null || manifesto.trim().isEmpty()) {
                        request.setAttribute("error", "Manifesto is required.");
                        break;
                    }
                    
                    if (manifesto.length() > 2500) {
                        request.setAttribute("error", "Manifesto must not exceed 500 words (2500 characters).");
                        break;
                    }
                    
                    try {
                        Position position = Position.valueOf(positionName);
                        boolean success = service.registerContester(user, position, manifesto.trim());
                        request.setAttribute("success", success ? "Contester registration request submitted and pending admin approval." : "Could not register as contester (position full or already registered).");
                    } catch (IllegalArgumentException e) {
                        request.setAttribute("error", "Invalid position selected.");
                    }
                    break;
                }
                case "withdraw": {
                    boolean success = service.withdrawContester(user);
                    request.setAttribute("success", success ? "You have withdrawn your manifesto/candidacy." : "Withdraw failed or not currently contesting.");
                    break;
                }
                case "vote": {
                    Election election = service.getCurrentElection();
                    boolean votingOpen = false;
                    if (election != null && election.getStartDate() != null && election.getEndDate() != null) {
                        java.time.LocalDateTime now = java.time.LocalDateTime.now();
                        votingOpen = now.isAfter(election.getStartDate()) && now.isBefore(election.getEndDate());
                    }
                    if (!votingOpen) {
                        request.setAttribute("error", "Voting is not currently open.");
                    } else if (service.hasUserVoted(user)) {
                        request.setAttribute("error", "You already voted.");
                    } else {
                        Long contesterId = null;
                        try {
                            contesterId = Long.parseLong(request.getParameter("contesterId"));
                        } catch (NumberFormatException ex) {
                            request.setAttribute("error", "Invalid contester selection.");
                        }
                        if (contesterId != null) {
                            boolean success = service.voteForContester(user, contesterId);
                            request.setAttribute("success", success ? "Vote recorded successfully." : "Could not cast vote. Ensure rules are followed.");
                        }
                    }
                    break;
                }
                case "profile": {
                    String firstName = request.getParameter("firstName");
                    String lastName = request.getParameter("lastName");

                    if (firstName == null || firstName.isEmpty() || lastName == null || lastName.isEmpty()) {
                        request.setAttribute("error", "First name and last name are required.");
                        break;
                    }

                    boolean success = service.updateProfile(user, firstName.trim(), lastName.trim(), null);
                    if (success) {
                        session.setAttribute("user", user);
                        request.setAttribute("success", "Profile updated successfully.");
                    } else {
                        request.setAttribute("error", "Failed to update profile.");
                    }
                    break;
                }
                case "changePassword": {
                    String currentPassword = request.getParameter("currentPassword");
                    String newPassword = request.getParameter("password");
                    String confirm = request.getParameter("confirmPassword");

                    if (currentPassword == null || currentPassword.isEmpty() || newPassword == null || newPassword.isEmpty()) {
                        request.setAttribute("error", "All password fields are required.");
                        break;
                    }

                    if (!newPassword.equals(confirm)) {
                        request.setAttribute("error", "New passwords do not match.");
                        break;
                    }

                    boolean success = service.changePassword(user, currentPassword, newPassword);
                    if (success) {
                        request.setAttribute("success", "Password changed successfully.");
                    } else {
                        request.setAttribute("error", "Current password is incorrect.");
                    }
                    break;
                }
                default:
                    if (action != null && !action.isEmpty()) {
                        request.setAttribute("error", "Unknown action.");
                    }
            }

            doGet(request, response);
        }
    }
}

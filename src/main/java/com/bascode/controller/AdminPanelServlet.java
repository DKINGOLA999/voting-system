package com.bascode.controller;

import java.io.IOException;
import java.util.List;

import com.bascode.model.entity.Contester;
import com.bascode.model.entity.Election;
import com.bascode.model.entity.User;
import com.bascode.model.enums.ContesterStatus;
import com.bascode.services.UserService;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/panel")
public class AdminPanelServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            !((User) session.getAttribute("user")).getRole().equals(com.bascode.model.enums.Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try (EntityManager em = JPAUtil.getEntityManager()) {
            UserService service = new UserServiceImpl(em);
            List<User> users = service.getAllUsers();
            List<Contester> pendingContesters = em.createQuery(
                    "SELECT c FROM Contester c WHERE c.status = :status", Contester.class)
                    .setParameter("status", ContesterStatus.PENDING)
                    .getResultList();

            Election currentElection = service.getCurrentElection();

            request.setAttribute("users", users);
            request.setAttribute("pendingContesters", pendingContesters);
            request.setAttribute("currentElection", currentElection);
            request.getRequestDispatcher("/WEB-INF/views/admin/adminPanel.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            !((User) session.getAttribute("user")).getRole().equals(com.bascode.model.enums.Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try (EntityManager em = JPAUtil.getEntityManager()) {
            UserService service = new UserServiceImpl(em);

            if ("approve".equals(action)) {
                try {
                    Long contesterId = Long.parseLong(request.getParameter("contesterId"));
                    Contester contester = em.find(Contester.class, contesterId);
                    if (contester != null && contester.getStatus() == ContesterStatus.PENDING) {
                        // Check if already 3 approved for this position
                        TypedQuery<Long> countQuery = em.createQuery(
                            "SELECT COUNT(c) FROM Contester c WHERE c.position = :position AND c.status = :status", Long.class);
                        countQuery.setParameter("position", contester.getPosition());
                        countQuery.setParameter("status", ContesterStatus.APPROVED);
                        Long approvedCount = countQuery.getSingleResult();
                        if (approvedCount >= 3) {
                            request.setAttribute("error", "Maximum 3 contesters allowed per position.");
                        } else {
                            em.getTransaction().begin();
                            contester.setStatus(ContesterStatus.APPROVED);
                            contester.getUser().setRole(com.bascode.model.enums.Role.CONTESTER);
                            em.merge(contester.getUser());
                            em.merge(contester);
                            em.getTransaction().commit();
                            request.setAttribute("success", "Contester approved.");
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid contester ID.");
                }
            } else if ("reject".equals(action)) {
                try {
                    Long contesterId = Long.parseLong(request.getParameter("contesterId"));
                    Contester contester = em.find(Contester.class, contesterId);
                    if (contester != null && contester.getStatus() == ContesterStatus.PENDING) {
                        em.getTransaction().begin();
                        contester.setStatus(ContesterStatus.DENIED);
                        em.merge(contester);
                        em.getTransaction().commit();
                        request.setAttribute("success", "Contester rejected.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid contester ID.");
                }
            } else if ("deleteUser".equals(action)) {
                try {
                    Long userId = Long.parseLong(request.getParameter("userId"));
                    if (service.deleteUser(userId)) {
                        request.setAttribute("success", "User deleted successfully.");
                    } else {
                        request.setAttribute("error", "Failed to delete user.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid user ID.");
                }
            } else if ("toggleSuspend".equals(action)) {
                try {
                    Long userId = Long.parseLong(request.getParameter("userId"));
                    if (service.suspendUser(userId)) {
                        request.setAttribute("success", "User status updated successfully.");
                    } else {
                        request.setAttribute("error", "Failed to update user status.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid user ID.");
                }
            } else if ("promoteAdmin".equals(action)) {
                try {
                    Long userId = Long.parseLong(request.getParameter("userId"));
                    if (service.promoteToAdmin(userId)) {
                        request.setAttribute("success", "User promoted to admin.");
                    } else {
                        request.setAttribute("error", "Failed to promote user.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid user ID.");
                }
            } else if ("setElectionDates".equals(action)) {
                try {
                    String startStr = request.getParameter("startDate");
                    String endStr = request.getParameter("endDate");
                    java.time.LocalDateTime start = java.time.LocalDateTime.parse(startStr);
                    java.time.LocalDateTime end = java.time.LocalDateTime.parse(endStr);
                    boolean success = service.setElectionDates(start, end);
                    request.setAttribute("success", success ? "Election dates set successfully." : "Failed to set election dates.");
                } catch (Exception e) {
                    request.setAttribute("error", "Invalid date format. Use YYYY-MM-DDTHH:MM format.");
                }
            } else if ("startElection".equals(action)) {
                boolean success = service.startElection();
                request.setAttribute("success", success ? "Election started." : "Failed to start election.");
            } else if ("endElection".equals(action)) {
                boolean success = service.endElection();
                request.setAttribute("success", success ? "Election ended." : "Failed to end election.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Action failed.");
        }

        doGet(request, response);
}
}

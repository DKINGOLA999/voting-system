package com.bascode.controller;

import java.io.IOException;

import com.bascode.model.entity.User;
import com.bascode.model.enums.Role;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            UserServiceImpl service = new UserServiceImpl(em);

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Please provide both email and password.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            email = email.trim().toLowerCase();

            User user = service.login(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());

                if (user.getRole() == Role.ADMIN) {
                    response.sendRedirect(request.getContextPath() + "/admin/panel");
                } else {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }

            } else {
                try {
                    jakarta.persistence.TypedQuery<User> q = em.createQuery(
                            "SELECT u FROM User u WHERE LOWER(u.email)=:email", User.class);
                    q.setParameter("email", email);
                    User found = q.getSingleResult();

                    if (found != null && !found.isEmailVerified()) {
                        request.setAttribute("email", email);
                        request.setAttribute("error", "Email not verified. Check your inbox or resend the code.");
                        request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp").forward(request, response);
                        return;
                    }
                } catch (jakarta.persistence.NoResultException nre) {
                    // not found -> generic message
                } catch (Exception ex) {
                    ex.printStackTrace();
                }

                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }

        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}

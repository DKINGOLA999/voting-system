package com.bascode.controller;

import com.bascode.services.UserService;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            request.setAttribute("error", "Email and OTP are required.");
            request.getRequestDispatcher("/otpReset.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/otpReset.jsp").forward(request, response);
            return;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            UserService service = new UserServiceImpl(em);
            boolean ok = service.resetPassword(email.trim().toLowerCase(), otp.trim(), newPassword);
            if (ok) {
                request.setAttribute("success", "Password has been reset. Please login.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid OTP or email. Please try again.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/otpReset.jsp").forward(request, response);
            }
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}

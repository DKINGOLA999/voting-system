package com.bascode.controller;

import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/verify", "/verifyOtp"})
public class OtpVerificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = null;
        try {
            em = JPAUtil.getEntityManager();
            UserServiceImpl service = new UserServiceImpl(em);

            String otp = request.getParameter("otp");
            String email = request.getParameter("email");

            if ((email == null || email.trim().isEmpty()) && request.getAttribute("email") != null) {
                email = request.getAttribute("email").toString();
            }

            if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
                request.setAttribute("error", "Email and OTP are required.");
                request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp").forward(request, response);
                return;
            }

            boolean ok = service.verifyEmail(email.trim().toLowerCase(), otp.trim());

            if (ok) {
                request.setAttribute("success", "Email verified successfully. Please login.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid OTP. Please try again.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp").forward(request, response);
            }

        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}


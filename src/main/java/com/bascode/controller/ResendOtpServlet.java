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

@WebServlet("/resendOtp")
public class ResendOtpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required to resend OTP.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp").forward(request, response);
            return;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            UserService service = new UserServiceImpl(em);
            boolean success = service.resendOtp(email.trim().toLowerCase());
            if (success) {
                request.setAttribute("success", "OTP resent successfully. Check your email.");
                request.setAttribute("email", email);
            } else {
                request.setAttribute("error", "Unable to resend OTP. Verify email or contact support.");
                request.setAttribute("email", email);
            }
            request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}

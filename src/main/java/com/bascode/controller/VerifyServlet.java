package com.bascode.controller;

import com.bascode.services.UserService;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class VerifyServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String code = request.getParameter("code");

        EntityManager em = JPAUtil.getEntityManager();
        UserService service = new UserServiceImpl(em);

        boolean verified = service.verifyEmail(email, code);

        if (verified) {
            request.setAttribute("message", "Account verified successfully!");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error", "Invalid verification code.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify.jsp")
                   .forward(request, response);
        }

        em.close();
    }
}
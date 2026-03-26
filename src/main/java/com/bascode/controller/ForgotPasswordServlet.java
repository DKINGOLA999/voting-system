package com.bascode.controller;

import com.bascode.services.UserService;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").toLowerCase();
        EntityManager em = JPAUtil.getEntityManager();
        UserService service = new UserServiceImpl(em);

        boolean sent = service.initiatePasswordReset(email);

        if(sent){
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            response.sendRedirect("otpReset.jsp");
        } else {
            request.setAttribute("error","Email not found!");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgotPassword.jsp")
                   .forward(request,response);
        }
        em.close();
    }
}
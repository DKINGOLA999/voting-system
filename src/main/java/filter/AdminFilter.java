package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.bascode.model.entity.User;

//@WebFilter("/admin/*") // This protects ALL pages starting with /admin/
public class AdminFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // 1. Check if user is logged in
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        // 2. Enforce the Role
        if (user != null && "ADMIN".equals(user.getRole())) {
            chain.doFilter(request, response); // Permission granted!
        } else {
            // 3. Kick them out!
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=AccessDenied");
        }
    }
}
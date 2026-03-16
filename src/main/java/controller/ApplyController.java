package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/apply")
public class ApplyController extends HttpServlet {

protected void doGet(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

request.getRequestDispatcher(
"/WEB-INF/views/apply.jsp"
).forward(request,response);

}

}
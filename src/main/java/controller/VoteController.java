package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

import com.bascode.dao.VoteDAO;

@WebServlet("/vote")
public class VoteController extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

Long contesterId =
Long.parseLong(request.getParameter("contesterId"));

HttpSession session = request.getSession();

Long voterId =
(Long) session.getAttribute("userId");

VoteDAO voteDAO = new VoteDAO();

voteDAO.castVote(voterId, contesterId);

response.sendRedirect(
request.getContextPath()+"/dashboard"
);

}

}
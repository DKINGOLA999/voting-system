package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import com.bascode.model.enums.Position;
import java.io.IOException;
import java.util.List;

import com.bascode.model.entity.*;
import com.bascode.dao.*;

@WebServlet("/admin")
public class Admincontroller extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- MERGE-SAFE AUTH CHECK ---
        HttpSession session = request.getSession();
        if (session.getAttribute("loggedUser") == null) {
            // Instead of redirecting to a missing login.jsp, we provide a temporary mock
            // This ensures you can still work even if your friends haven't finished the login
            User tempAdmin = new User();
            tempAdmin.setFirstName("System");
            tempAdmin.setLastName("Admin");
            session.setAttribute("loggedUser", tempAdmin);
        }

        String action = request.getParameter("action");
        if (action == null) { action = "dashboard"; }

        switch (action) {
            case "dashboard": handleDashboard(request, response); break;
            case "voters":    handleVoters(request, response); break;
            case "settings":  handleSettings(request, response); break;
            case "contester": handleContesters(request, response); break;
            case "vote":      handleVotes(request, response); break;
            case "result":    handleResults(request, response); break;
            case "user":
                request.getRequestDispatcher("/WEB-INF/views/admin/user.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("admin?action=dashboard");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // --- REAL-TIME SETTINGS SAVE ---
        if ("saveSettings".equals(action)) {
            SettingsDAO settingsDAO = new SettingsDAO();
            
            // Get current ID 1 from DB or create new
            Setting setting = settingsDAO.getSettings();
            if (setting == null) { setting = new Setting(); setting.setId(1); }

            setting.setElectionName(request.getParameter("electionName"));
            setting.setStartDate(request.getParameter("startDate"));
            setting.setEndDate(request.getParameter("endDate"));

            settingsDAO.updateSettings(setting);

            // Success redirect
            response.sendRedirect(request.getContextPath() + "/admin?action=settings&msg=success");
        } else {
            doGet(request, response);
        }
    }

    // --- HELPER METHODS ---
    private void handleSettings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SettingsDAO settingsDAO = new SettingsDAO();
        request.setAttribute("setting", settingsDAO.getSettings());
        request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp").forward(request, response);
    }

    private void handleDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VoterDAO voterDAO = new VoterDAO();
        ContestantDAO contestantDAO = new ContestantDAO();
        VoteDAO voteDAO = new VoteDAO();
        UserDAO userDAO = new UserDAO();
        
        List<Voter> voters = voterDAO.getAllVoters();
        request.setAttribute("totalVoters", voters.size());
        request.setAttribute("totalContesters", contestantDAO.getAllContestants().size());
        request.setAttribute("totalVotes", voteDAO.getAllVotes().size());
        request.setAttribute("totalUsers", userDAO.countUsers());
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void handleVoters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VoterDAO voterDAO = new VoterDAO();
        request.setAttribute("voters", voterDAO.getAllVoters());
        request.getRequestDispatcher("/WEB-INF/views/admin/voters.jsp").forward(request, response);
    }

    private void handleContesters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ContestantDAO contestantDAO = new ContestantDAO();
        request.setAttribute("contesters", contestantDAO.getAllContestants());
        request.getRequestDispatcher("/WEB-INF/views/admin/contester.jsp").forward(request, response);
    }

    private void handleVotes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VoteDAO voteDAO = new VoteDAO();
        request.setAttribute("vote", voteDAO.getAllVotes());
        request.getRequestDispatcher("/WEB-INF/views/admin/vote.jsp").forward(request, response);
    }

    private void handleResults(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ContestantDAO contestantDAO = new ContestantDAO();
        request.setAttribute("allContesters", contestantDAO.getAllContestantsOrderedByVotes());
        request.getRequestDispatcher("/WEB-INF/views/admin/result.jsp").forward(request, response);
    }
}
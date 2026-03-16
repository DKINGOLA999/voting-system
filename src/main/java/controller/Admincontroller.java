package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import com.bascode.model.enums.Position;

import java.io.IOException;
import java.util.List;

import com.bascode.model.entity.Voter;
import com.bascode.model.entity.Contester;
import com.bascode.model.entity.Setting;
import com.bascode.model.entity.User;
import com.bascode.model.entity.Vote;

import com.bascode.dao.VoterDAO;
import com.bascode.dao.ContestantDAO;
import com.bascode.dao.SettingsDAO;
import com.bascode.dao.UserDAO;
import com.bascode.dao.VoteDAO;

@WebServlet("/admin")
public class Admincontroller extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "dashboard";
        }

        if (action.equals("dashboard")) {

            VoterDAO voterDAO = new VoterDAO();
            ContestantDAO contestantDAO = new ContestantDAO();
            VoteDAO voteDAO = new VoteDAO();
            UserDAO userDAO = new UserDAO();
            
            List<Voter> voters = voterDAO.getAllVoters();
            List<Contester> contesters = contestantDAO.getAllContestants();
            List<Vote> votes = voteDAO.getAllVotes();
            List<User> users = userDAO.getAllUsers();
            Long totalUsers = userDAO.countUsers();;


            int presidentVotes = 0;
            int viceVotes = 0;
            int secretaryVotes = 0;
            int treasurerVotes = 0;

            for(Vote v : votes){

            Position pos = v.getContester().getPosition();

            if(pos.equals("President")) presidentVotes++;
            if(pos.equals("Vice President")) viceVotes++;
            if(pos.equals("Secretary")) secretaryVotes++;
            if(pos.equals("Treasurer")) treasurerVotes++;

            }

            request.setAttribute("presidentVotes", presidentVotes);
            request.setAttribute("viceVotes", viceVotes);
            request.setAttribute("secretaryVotes", secretaryVotes);
            request.setAttribute("treasurerVotes", treasurerVotes);

            request.setAttribute("voters", voters);
            request.setAttribute("contesters", contesters);
            request.setAttribute("votes", votes);
            request.setAttribute("users", users);

            request.setAttribute("totalVoters", voters.size());
            request.setAttribute("totalContesters", contesters.size());
            request.setAttribute("totalVotes", votes.size());
            request.setAttribute("totalUsers", totalUsers);

           

            request.setAttribute("presidentVotes", 
                voteDAO.countByPosition(Position.PRESIDENT));

            request.setAttribute("viceVotes", 
                voteDAO.countByPosition(Position.VICE_PRESIDENT));

            request.setAttribute("secretaryVotes", 
                voteDAO.countByPosition(Position.SECRETARY));

            request.setAttribute("treasurerVotes", 
                voteDAO.countByPosition(Position.TREASURER));

            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                    .forward(request, response);
        }

      
        
        else if (action.equals("voters")) {

            VoterDAO voterDAO = new VoterDAO();

            String search = request.getParameter("search");

            List<Voter> voters;

            if(search != null && !search.isEmpty()){
                voters = voterDAO.searchByEmail(search);
            } else {
                voters = voterDAO.getAllVoters();
            }

            request.setAttribute("voters", voters);

            request.getRequestDispatcher("/WEB-INF/views/admin/voters.jsp")
                    .forward(request, response);
        }
        
        else if(action.equals("user")){
        request.getRequestDispatcher("/WEB-INF/views/admin/user.jsp")
        .forward(request, response);
        }
        
        else if(action.equals("settings")){
            request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp")
            .forward(request, response);
            }
        
        else if(action.equals("result")){
            request.getRequestDispatcher("/WEB-INF/views/admin/result.jsp")
            .forward(request, response);
            }
        
        else if (action.equals("contester")) {

            ContestantDAO contestantDAO = new ContestantDAO();

            request.setAttribute("contesters", contestantDAO.getAllContestants());

            request.getRequestDispatcher("/WEB-INF/views/admin/contester.jsp")
                    .forward(request, response);
        }

        else if (action.equals("vote")) {

            VoteDAO voteDAO = new VoteDAO();

            request.setAttribute("vote", voteDAO.getAllVotes());

            request.getRequestDispatcher("/WEB-INF/views/admin/vote.jsp")
                    .forward(request, response);
        }
        
        else if(action.equals("approve")){

        	Long id =
        	Long.parseLong(request.getParameter("id"));

        	ContestantDAO dao = new ContestantDAO();

        	dao.approve(id);

        	response.sendRedirect(
        	request.getContextPath()+"/admin?action=contester"
        	);

        	}

        	else if(action.equals("deny")){

        	Long id =
        	Long.parseLong(request.getParameter("id"));

        	ContestantDAO dao = new ContestantDAO();

        	dao.deny(id);

        	response.sendRedirect(
        	request.getContextPath()+"/admin?action=contester"
        	);

        	}
        
        	else if(action.equals("settings")){

        	    SettingsDAO dao = new SettingsDAO();

        	    Setting setting = dao.getSettings();

        	    request.setAttribute("setting", setting);

        	    request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp")
        	            .forward(request,response);
        	}
        
        	else if(action.equals("saveSettings")){

        	    String electionName = request.getParameter("electionName");
        	    String startDate = request.getParameter("startDate");
        	    String endDate = request.getParameter("endDate");

        	    SettingsDAO dao = new SettingsDAO();

        	    dao.saveSettings(electionName,startDate,endDate);

        	    response.sendRedirect("admin?action=settings");
        	}
       
    }
}
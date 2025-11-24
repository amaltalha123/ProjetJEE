package com.projet.jee.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.projet.jee.dao.StatisticsDAO;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.dto.SessionUser;
import com.projet.jee.model.Manager;

/**
 * Servlet implementation class Statistics
 */
@WebServlet("/secured/Statistics")
public class Statistics extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserRepository userRepo = new UserRepository();
	private StatisticsDAO statisticsDAO;
    @Override
    public void init() throws ServletException {
        // Initialiser EntityManagerFactory et EntityManager
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");  // Remplace par ton unité de persistance
        EntityManager em = emf.createEntityManager();
        statisticsDAO = new StatisticsDAO(em);
        
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
        SessionUser sessionUser = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;
        
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Manager manager = userRepo.find((long) sessionUser.getId());
        // Récupérer les statistiques
        Long activeServices = statisticsDAO.getActiveServicesCount(sessionUser.getId());
        Long archivedServices = statisticsDAO.getArchivedServicesCount(sessionUser.getId());
        Long totalRequests = statisticsDAO.getTotalRequestsCount(sessionUser.getId());
        Long totalComplaints = statisticsDAO.getTotalComplaintsCount(sessionUser.getId());
        // Mettre les valeurs dans les attributs de la requête
        request.setAttribute("activeServices", activeServices);
        request.setAttribute("archivedServices", archivedServices);
        request.setAttribute("totalRequests", totalRequests);
        request.setAttribute("totalComplaints", totalComplaints);
        // Forwarder vers la JSP
        request.getRequestDispatcher("/JSP/secured/manager/statistiques.jsp").forward(request, response);  // Ajuste le chemin vers ta JSP
    }

}
